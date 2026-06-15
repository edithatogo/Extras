param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$ChocolateyPackagesPath = (Join-Path $PSScriptRoot '..\..\packaging\chocolatey'),
    [string]$OutputPath = (Join-Path ([System.IO.Path]::GetTempPath()) 'scoop-extras-chocolatey-pack')
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
$choco = Get-Command choco -ErrorAction SilentlyContinue
if (-not $choco) {
    throw 'Chocolatey CLI is required to validate implemented Chocolatey package sources.'
}

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File |
    Sort-Object Name |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json } |
    Where-Object { $_.targets.chocolatey.status -eq 'implemented' }

Remove-Item -LiteralPath $OutputPath -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null

foreach ($contract in $contracts) {
    $packageId = if ($contract.targets.chocolatey.package_id) { $contract.targets.chocolatey.package_id } else { $contract.id }
    $packageRoot = Join-Path $ChocolateyPackagesPath $packageId
    $nuspec = Join-Path $packageRoot "$packageId.nuspec"

    if (-not (Test-Path -LiteralPath $nuspec)) {
        Add-Failure $failures "$($contract.id) missing Chocolatey nuspec: $nuspec"
        continue
    }

    Push-Location $packageRoot
    try {
        $output = & $choco.Source pack --out $OutputPath 2>&1
        if ($LASTEXITCODE -ne 0) {
            Add-Failure $failures "$packageId choco pack failed with exit code $LASTEXITCODE. $($output -join [Environment]::NewLine)"
            continue
        }
    }
    finally {
        Pop-Location
    }

    $version = (Get-Content -Raw -LiteralPath $nuspec) -replace '(?s).*<version>([^<]+)</version>.*', '$1'
    $expected = Join-Path $OutputPath "$packageId.$version.nupkg"
    if (-not (Test-Path -LiteralPath $expected)) {
        Add-Failure $failures "$packageId did not produce expected package artifact: $expected"
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Packed $($contracts.Count) Chocolatey package sources."
exit 0
