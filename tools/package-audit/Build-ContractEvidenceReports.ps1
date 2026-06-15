param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$ReportsPath = (Join-Path $PSScriptRoot '..\..\packaging\reports')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Format-List {
    param([object[]]$Items)

    if (-not $Items -or $Items.Count -eq 0) {
        return @('- none recorded')
    }

    return @($Items | ForEach-Object { "- $_" })
}

function Write-AsciiReport {
    param(
        [string]$Path,
        [string[]]$Lines
    )

    $dir = Split-Path -Parent $Path
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $Lines | Set-Content -LiteralPath $Path -Encoding Ascii
}

$repoRoot = (Resolve-Path "$PSScriptRoot\..\..").Path
New-Item -ItemType Directory -Force -Path $ReportsPath | Out-Null

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File |
    Sort-Object Name |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json }

foreach ($contract in $contracts) {
    $hardeningReport = Join-Path $repoRoot $contract.readiness.hardening_report
    $smokeReport = Join-Path $repoRoot $contract.readiness.smoke_report

    $sourceLines = if ($contract.PSObject.Properties['sources']) {
        @($contract.sources | ForEach-Object {
            $source = $_
            $sourcePath = if ($source.PSObject.Properties['path']) { $source.path } elseif ($source.PSObject.Properties['url']) { $source.url } else { 'unspecified' }
            "- $($source.type): $sourcePath ($($source.status))"
        })
    }
    else {
        @('- no explicit source entries; see installer evidence and duplicate lookup terms')
    }

    $hardeningLines = [System.Collections.Generic.List[string]]::new()
    $hardeningLines.Add("# $($contract.name) Hardening Evidence")
    $hardeningLines.Add('')
    $hardeningLines.Add("- Contract: ``$($contract.id)``")
    $hardeningLines.Add("- Track: ``$($contract.track)``")
    $hardeningLines.Add("- Last reviewed: $($contract.readiness.last_reviewed)")
    $hardeningLines.Add("- Readiness state: ``$($contract.readiness.state)``")
    $hardeningLines.Add("- Runtime validation: ``$($contract.readiness.runtime_validation)``")
    $hardeningLines.Add('')
    $hardeningLines.Add('## Source Evidence')
    foreach ($line in @($sourceLines)) { $hardeningLines.Add($line) }
    $hardeningLines.Add('')
    $hardeningLines.Add('## Installer Evidence')
    foreach ($line in @(Format-List -Items $contract.installer.evidence)) { $hardeningLines.Add($line) }
    $hardeningLines.Add('')
    $hardeningLines.Add('## No-Admin Strategy')
    $hardeningLines.Add($contract.no_admin.strategy)
    $hardeningLines.Add('')
    $hardeningLines.Add('## Hard Blockers')
    foreach ($line in @(Format-List -Items $contract.no_admin.hard_blockers)) { $hardeningLines.Add($line) }
    $hardeningLines.Add('')
    $hardeningLines.Add('## Target Posture')
    $hardeningLines.Add("- Scoop: ``$($contract.targets.scoop.status)`` - $($contract.targets.scoop.no_admin_strategy)")
    $hardeningLines.Add("- Chocolatey: ``$($contract.targets.chocolatey.status)`` - $($contract.targets.chocolatey.no_admin_strategy)")
    $hardeningLines.Add('')
    $hardeningLines.Add('## Decision')
    $hardeningLines.Add($contract.readiness.decision)

    $smokeLines = [System.Collections.Generic.List[string]]::new()
    $smokeLines.Add("# $($contract.name) No-Admin Smoke Evidence")
    $smokeLines.Add('')
    $smokeLines.Add("- Contract: ``$($contract.id)``")
    $smokeLines.Add("- Track: ``$($contract.track)``")
    $smokeLines.Add("- Last reviewed: $($contract.readiness.last_reviewed)")
    $smokeLines.Add("- Runtime validation: ``$($contract.readiness.runtime_validation)``")
    $smokeLines.Add('')
    $smokeLines.Add('| Gate | Status | Evidence |')
    $smokeLines.Add('| --- | --- | --- |')
    if ($contract.readiness.runtime_validation -eq 'passed') {
        $smokeLines.Add('| Install without UAC | pass | Runtime smoke recorded as passed in contract. |')
        $smokeLines.Add('| Launch primary binary | pass | Runtime smoke recorded as passed in contract. |')
        $smokeLines.Add('| Uninstall cleanup | pass | Runtime smoke recorded as passed in contract. |')
        $smokeLines.Add('| No HKLM/Program Files/service side effects | pass | Runtime smoke recorded as passed in contract. |')
    }
    elseif ($contract.readiness.runtime_validation -eq 'blocked') {
        $smokeLines.Add('| Install without UAC | blocked | Contract is blocked by package-boundary or policy constraints. |')
        $smokeLines.Add('| Launch primary binary | blocked | No supported desktop package route is approved. |')
        $smokeLines.Add('| Uninstall cleanup | blocked | No install route is approved. |')
        $smokeLines.Add('| No HKLM/Program Files/service side effects | blocked | Blockers are listed in the hardening report. |')
    }
    else {
        $smokeLines.Add('| Install without UAC | not-run | Isolated runtime validation has not been executed. |')
        $smokeLines.Add('| Launch primary binary | not-run | Isolated runtime validation has not been executed. |')
        $smokeLines.Add('| Uninstall cleanup | not-run | Isolated runtime validation has not been executed. |')
        $smokeLines.Add('| No HKLM/Program Files/service side effects | not-run | Isolated runtime validation has not been executed. |')
    }
    $smokeLines.Add('')
    $smokeLines.Add('## Exit Rule')
    $smokeLines.Add('A candidate is not hardened-complete until all smoke gates pass in an isolated user-scope install, launch, and uninstall run.')

    Write-AsciiReport -Path $hardeningReport -Lines $hardeningLines
    Write-AsciiReport -Path $smokeReport -Lines $smokeLines
}

Write-Host "Wrote evidence reports for $($contracts.Count) contracts."
