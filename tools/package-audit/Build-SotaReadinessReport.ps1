param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$CachePath = (Join-Path $PSScriptRoot '..\..\packaging\cache\package-existence.json'),
    [string]$ReportPath = (Join-Path $PSScriptRoot '..\..\packaging\reports\sota-readiness.md')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Get-Snapshot {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return @{}
    }

    try {
        return Get-Content -Raw -LiteralPath $Path | ConvertFrom-Json
    }
    catch {
        Write-Warning "Unable to read package existence cache at ${Path}: $($_.Exception.Message)"
        return @{}
    }
}

function Resolve-ReportFile {
    param([string]$ReportRoot, [string]$Id, [string]$Suffix)
    return Join-Path $ReportRoot "$Id-$Suffix"
}

function Read-FirstResult {
    param($Value)
    if ($null -eq $Value) { return 'not checked' }
    if (-not $Value.status) { return 'not checked' }

    if ($Value.status -eq 'ok') {
        if ($Value.results.Count -gt 0) {
            return ($Value.results -join '; ')
        }
        return 'none'
    }

    return $Value.status
}

$snapshot = Get-Snapshot -Path $CachePath
$reportRoot = Split-Path -Parent $ReportPath
$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File |
    Sort-Object Name |
    ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json }

$reportRows = foreach ($contract in $contracts) {
    $id = $contract.id
    $entry = $snapshot.contracts | Where-Object { $_.id -eq $id } | Select-Object -First 1

    $localScoop = if ($entry) { Read-FirstResult $entry.local_scoop } else { 'not checked' }
    $chocoLookup = if ($entry) { Read-FirstResult $entry.chocolatey } else { 'not checked' }
    $wingetLookup = if ($entry) { Read-FirstResult $entry.winget } else { 'not checked' }

    $hasHardening = Test-Path -LiteralPath (Resolve-ReportFile -ReportRoot $reportRoot -Id $id -Suffix 'hardening.md')
    $hasSmoke = Test-Path -LiteralPath (Resolve-ReportFile -ReportRoot $reportRoot -Id $id -Suffix 'noadmin-smoke.md')

    $scoopState = $contract.targets.scoop.status
    $chocoState = $contract.targets.chocolatey.status
    $candidate = $contract.candidate_status

    $evidenceSummary = "hardening:$(if ($hasHardening) { 'yes' } else { 'no' }), smoke:$(if ($hasSmoke) { 'yes' } else { 'no' })"
    $contractReadiness = if ($contract.PSObject.Properties['readiness']) { $contract.readiness.state } else { $null }
    $runtimeValidation = if ($contract.PSObject.Properties['readiness']) { $contract.readiness.runtime_validation } else { 'unknown' }
    $sotaStatus = if ($contractReadiness) {
        $contractReadiness
    }
    elseif ($candidate -eq 'blocked' -or ($scoopState -eq 'blocked' -and $chocoState -eq 'blocked')) {
        'blocked'
    }
    elseif ($scoopState -eq 'implemented' -and $hasHardening -and $hasSmoke -and $runtimeValidation -eq 'passed') {
        'implemented'
    }
    elseif ($candidate -eq 'deferred' -or $scoopState -eq 'deferred' -or $chocoState -eq 'deferred') {
        'deferred'
    }
    else {
        'candidate-requires-runtime-validation'
    }

    [pscustomobject]@{
        Name       = $contract.name
        Id         = $id
        Priority   = $contract.priority
        Candidate  = $candidate
        Scoop      = $scoopState
        Choco      = $chocoState
        Evidence   = $evidenceSummary
        Runtime    = $runtimeValidation
        Track      = if ($contract.PSObject.Properties['track']) { $contract.track } else { '-' }
        SotaStatus = $sotaStatus
        Duplicate  = "scoop=$localScoop ; choco=$chocoLookup ; winget=$wingetLookup"
    }
}

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# SOTA Readiness Report')
$lines.Add('')
$lines.Add("Generated: $((Get-Date).ToUniversalTime().ToString('o'))")
$lines.Add('')
$lines.Add('This report consolidates no-admin readiness and duplicate-lookup signals per contract.')
$lines.Add('')
$lines.Add('| Candidate | Priority | Candidate | Scoop | Choco | Runtime | Evidence | SOTA Status | Track | Duplicate Signals |')
$lines.Add('| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')

foreach ($row in $reportRows | Sort-Object Priority, Name) {
    $lines.Add("| $($row.Name) | $($row.Priority) | $($row.Candidate) | $($row.Scoop) | $($row.Choco) | $($row.Runtime) | $($row.Evidence) | $($row.SotaStatus) | $($row.Track) | $($row.Duplicate) |")
}

$lines.Add('')
$lines.Add('Decision legend:')
$lines.Add('- `blocked`: contract explicitly blocked, or both targets blocked.')
$lines.Add('- `implemented`: contract declares implemented and runtime validation has passed.')
$lines.Add('- `covered`: package is covered by an existing upstream route and should not be duplicated here.')
$lines.Add('- `candidate-requires-runtime-validation`: candidate/implemented-by-manifest and evidence artifacts are incomplete or not yet runtime-verified.')
$lines.Add('- `deferred`: explicitly marked as deferred.')

$reportDir = Split-Path -Parent $ReportPath
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
$lines | Set-Content -LiteralPath $ReportPath -Encoding Ascii

Write-Host "Wrote $ReportPath"
