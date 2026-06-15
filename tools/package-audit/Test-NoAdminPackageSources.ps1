param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$ChocolateyPackagesPath = (Join-Path $PSScriptRoot '..\..\packaging\chocolatey')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Add-Failure {
    param(
        [System.Collections.Generic.List[string]]$Failures,
        [string]$Message
    )
    $Failures.Add($Message)
}

$failures = [System.Collections.Generic.List[string]]::new()
$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File |
    Sort-Object Name |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json }

$blockedInstallPatterns = @(
    'Start-ChocolateyProcessAsAdmin',
    'Install-ChocolateyInstallPackage',
    'Install-ChocolateyPackage',
    '\bmsiexec(\.exe)?\s+/i\b',
    '\$env:ProgramFiles',
    '\$env:ProgramFiles\(x86\)',
    'Program Files',
    'HKLM:',
    'New-Service',
    'Set-Service',
    'sc\.exe\s+create',
    'Start-Service',
    'Add-MpPreference',
    'Set-ExecutionPolicy'
)

foreach ($contract in $contracts) {
    if ($contract.targets.chocolatey.status -ne 'implemented') {
        continue
    }

    $packageId = if ($contract.targets.chocolatey.package_id) { $contract.targets.chocolatey.package_id } else { $contract.id }
    $packageRoot = Join-Path $ChocolateyPackagesPath $packageId
    $installScript = Join-Path $packageRoot 'tools\chocolateyinstall.ps1'
    $uninstallScript = Join-Path $packageRoot 'tools\chocolateyuninstall.ps1'

    foreach ($required in @($installScript, $uninstallScript)) {
        if (-not (Test-Path -LiteralPath $required)) {
            Add-Failure $failures "$($contract.id) missing required package source file: $required"
        }
    }

    if (Test-Path -LiteralPath $installScript) {
        $script = Get-Content -Raw -LiteralPath $installScript
        foreach ($pattern in $blockedInstallPatterns) {
            if ($script -match $pattern) {
                Add-Failure $failures "$($contract.id) Chocolatey install script contains blocked no-admin pattern: $pattern"
            }
        }

        if ($script -notmatch '\$toolsDir') {
            Add-Failure $failures "$($contract.id) Chocolatey install script must anchor payloads under `$toolsDir."
        }

        if ($contract.installer.type -in @('msi', 'nsis', 'inno') -and $script -notmatch '(7z|Get-ChocolateyUnzip|Expand-|[''"]/a[''"])') {
            Add-Failure $failures "$($contract.id) installer package source must use an extraction-first path."
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host 'Validated no-admin package source guardrails.'
exit 0
