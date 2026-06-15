param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$ReportPath = (Join-Path $PSScriptRoot '..\..\packaging\reports\candidate-ranking.md')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File | Sort-Object Name | ForEach-Object {
    Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
}

$priorityRank = @{
    'requested'   = 0
    'high-signal' = 1
    'audit-only'  = 2
}

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# Candidate Ranking')
$lines.Add('')
$lines.Add('Candidates are ranked by request priority, no-admin feasibility, and absence of local Scoop coverage.')
$lines.Add('')
$lines.Add('| Candidate | Priority | Version | Readiness | Runtime | Installer | Scoop Target | Chocolatey Target | Track | No-Admin Strategy |')
$lines.Add('| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')

foreach ($contract in $contracts | Sort-Object @{ Expression = { $priorityRank[$_.priority] } }, name) {
    $version = if ($contract.version) { $contract.version } else { 'unknown' }
    $readiness = if ($contract.PSObject.Properties['readiness']) { $contract.readiness.state } else { '-' }
    $runtime = if ($contract.PSObject.Properties['readiness']) { $contract.readiness.runtime_validation } else { '-' }
    $track = if ($contract.PSObject.Properties['track']) { $contract.track } else { '-' }
    $lines.Add("| $($contract.name) | $($contract.priority) | $version | $readiness | $runtime | $($contract.installer.type) | $($contract.targets.scoop.status) | $($contract.targets.chocolatey.status) | $track | $($contract.no_admin.strategy) |")
}

$reportDir = Split-Path -Parent $ReportPath
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
$lines | Set-Content -LiteralPath $ReportPath -Encoding Ascii
Write-Host "Wrote $ReportPath"
