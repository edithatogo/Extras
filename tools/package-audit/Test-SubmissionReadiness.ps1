param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$SubmissionsPath = (Join-Path $PSScriptRoot '..\..\packaging\submissions'),
    [string]$ChocolateyPackagesPath = (Join-Path $PSScriptRoot '..\..\packaging\chocolatey')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path "$PSScriptRoot\..\..").Path
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message)
}

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File |
    Sort-Object Name |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json }

foreach ($contract in $contracts) {
    $id = $contract.id

    foreach ($report in @($contract.readiness.hardening_report, $contract.readiness.smoke_report)) {
        if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $report))) {
            Add-Failure "$id is missing evidence report $report"
        }
    }

    if ($contract.targets.scoop.status -eq 'implemented') {
        if (-not $contract.targets.scoop.expected_manifest) {
            Add-Failure "$id has implemented Scoop target without expected_manifest"
        }
        elseif (-not (Test-Path -LiteralPath (Join-Path $repoRoot $contract.targets.scoop.expected_manifest))) {
            Add-Failure "$id points to missing Scoop manifest $($contract.targets.scoop.expected_manifest)"
        }

        $scoopSubmission = Join-Path $SubmissionsPath "scoop\$id.md"
        if (-not (Test-Path -LiteralPath $scoopSubmission)) {
            Add-Failure "$id has implemented Scoop target without submission checklist $scoopSubmission"
        }
    }

    if ($contract.targets.chocolatey.status -in @('candidate', 'implemented')) {
        $chocoSubmission = Join-Path $SubmissionsPath "chocolatey\$id.md"
        if (-not (Test-Path -LiteralPath $chocoSubmission)) {
            Add-Failure "$id has Chocolatey $($contract.targets.chocolatey.status) target without submission note $chocoSubmission"
        }
    }

    if ($contract.targets.chocolatey.status -eq 'implemented') {
        $packageId = if ($contract.targets.chocolatey.package_id) { $contract.targets.chocolatey.package_id } else { $id }
        $packageRoot = Join-Path $ChocolateyPackagesPath $packageId
        $nuspec = Join-Path $packageRoot "$packageId.nuspec"
        $installScript = Join-Path $packageRoot 'tools\chocolateyinstall.ps1'

        if (-not (Test-Path -LiteralPath $nuspec)) {
            Add-Failure "$id has implemented Chocolatey target without package spec $nuspec"
        }
        if (-not (Test-Path -LiteralPath $installScript)) {
            Add-Failure "$id has implemented Chocolatey target without install script $installScript"
        }

        if (Test-Path -LiteralPath $installScript) {
            $script = Get-Content -Raw -LiteralPath $installScript
            foreach ($blockedPattern in @(
                'Start-ChocolateyProcessAsAdmin',
                'Install-ChocolateyInstallPackage',
                'Install-ChocolateyPackage',
                '\$env:ProgramFiles',
                'Program Files',
                'HKLM:',
                'New-Service',
                'Set-Service'
            )) {
                if ($script -match $blockedPattern) {
                    Add-Failure "$id Chocolatey install script contains blocked no-admin pattern: $blockedPattern"
                }
            }
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated submission readiness for $($contracts.Count) contracts."
