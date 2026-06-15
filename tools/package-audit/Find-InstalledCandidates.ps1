param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$ReportPath = (Join-Path $PSScriptRoot '..\..\packaging\reports\installed-candidates-review.md'),
    [switch]$EmitObject,
    [int]$MaxUnmatched = 120
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Get-ManagerInventory {
    param(
        [scriptblock]$Lookup,
        [string]$Label,
        [scriptblock]$ParseLine
    )

    try {
        $result = @(& $Lookup *>&1)
    }
    catch {
        return @{
            status = 'failed'
            error  = $_.Exception.Message
            items  = @()
        }
    }

    $items = [System.Collections.Generic.List[string]]::new()
    foreach ($line in $result) {
        if ($null -eq $line) {
            continue
        }

        $itemName = $null
        $trimmed = if ($line -is [string]) { $line.Trim() } else { $null }
        if ($line -is [psobject]) {
            if ($line.PSObject.Properties['Name']) {
                $itemName = "$($line.Name)"
            }
            elseif ($line.PSObject.Properties['PackageIdentifier']) {
                $itemName = "$($line.PackageIdentifier)"
            }
            elseif ($line.PSObject.Properties['Id']) {
                $itemName = "$($line.Id)"
            }
            elseif ($line.PSObject.Properties['Title']) {
                $itemName = "$($line.Title)"
            }
        }

        if (-not $itemName) {
            if (-not $trimmed) {
                $trimmed = "$line".Trim()
                if (-not $trimmed) {
                    continue
                }
            }
            $itemName = & $ParseLine $trimmed
        }

        $parsed = $itemName
        if ($parsed) {
            $items.Add($parsed)
        }
    }

    return @{
        status = 'ok'
        items  = @($items | Sort-Object -Unique)
        error  = $null
    }
}

function Invoke-ManagerCommand {
    param(
        [string]$Name,
        [scriptblock[]]$Candidates
    )

    foreach ($candidate in $Candidates) {
        try {
            $result = @(& $candidate *>&1)
            if ($LASTEXITCODE -eq 0) {
                return @{
                    status = 'ok'
                    output = @($result)
                    error  = $null
                }
            }
        }
        catch {
            # Try remaining variants.
        }
    }

    return @{
        status = 'failed'
        output = @()
        error  = "All $Name command variants failed."
    }
}

function Get-ScoopInstalled {
    $scoopExe = Join-Path $env:USERPROFILE 'scoop\shims\scoop.exe'
    if (Test-Path -LiteralPath $scoopExe) {
        $data = Get-ManagerInventory -Lookup { & $scoopExe list } -Label 'scoop' -ParseLine {
            param([string]$Line)
            if ($Line -match '^\s*([^\s]+)\s+([0-9][^\s]*)') {
                $Matches[1]
            }
        }
        return @{
            status = 'ok'
            items  = $data.items
            error  = $data.error
        }
    }

    $command = Get-Command scoop -ErrorAction SilentlyContinue
    if (-not $command) {
        return @{ status = 'missing'; items = @(); error = $null }
    }
    $data = Get-ManagerInventory -Lookup { & $command.Source list } -Label 'scoop' -ParseLine {
        param([string]$Line)
        if ($Line -match '^\s*([^\s]+)\s+([0-9][^\s]*)') {
            $Matches[1]
        }
    }
    return @{
        status = 'ok'
        items  = $data.items
        error  = $data.error
    }
}

function Get-ChocoInstalled {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        return @{ status = 'missing'; items = @(); error = $null }
    }

    $data = Invoke-ManagerCommand -Name 'Chocolatey' -Candidates {
        { choco list -lo -r }
        { choco list --limit-output --local-only }
        { choco list -r --local-only }
        { choco list --local-only }
        { choco list -r }
    }

    if ($data.status -ne 'ok') {
        return @{
            status = 'failed'
            items  = @()
            error  = $data.error
        }
    }

    $items = [System.Collections.Generic.List[string]]::new()
    foreach ($line in $data.output) {
        if ($line -match '^([^|]+)\|') {
            $items.Add($Matches[1].Trim())
        }
        elseif ($line -match '^\s*([^|\s]+)\s+[0-9]+(?:\.[0-9]+)?') {
            $items.Add($Matches[1].Trim())
        }
    }

    return @{
        status = 'ok'
        items  = @($items | Sort-Object -Unique)
        error  = $null
    }
}

function Get-WinGetInstalled {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        return @{ status = 'missing'; items = @(); error = $null }
    }

    $data = Invoke-ManagerCommand -Name 'WinGet' -Candidates {
        { winget list --disable-interactivity --accept-source-agreements --output json 2>$null }
        { winget list --output json 2>$null }
        { winget list --accept-source-agreements --disable-interactivity 2>$null }
        { winget list 2>$null }
    }

    if ($data.status -ne 'ok') {
        return @{
            status = 'failed'
            items  = @()
            error  = $data.error
        }
    }

    $payloadText = $data.output -join "`n"
    if (-not $payloadText) {
        return @{
            status = 'failed'
            items  = @()
            error  = 'No WinGet output returned'
        }
    }

    try {
        $objects = $payloadText | ConvertFrom-Json
    }
    catch {
        $items = [System.Collections.Generic.List[string]]::new()
        foreach ($line in $data.output) {
            $trimmed = "$line".Trim()
            if (-not $trimmed) {
                continue
            }
            if ($trimmed -match '^\s*([^|\s][^|]*)\s+\|\s+[0-9].*') {
                $items.Add($Matches[1].Trim())
            }
            elseif ($trimmed -match '^\s*([A-Za-z0-9][A-Za-z0-9\.\-\+_]+)\s+[0-9]+\.[0-9]') {
                $items.Add($Matches[1].Trim())
            }
        }

        if ($items.Count -eq 0) {
            return @{
                status = 'failed'
                items = @()
                error = 'Unable to parse WinGet output as JSON or parseable table output'
            }
        }

        return @{
            status = 'ok'
            items = @($items | Sort-Object -Unique)
            error = $null
        }
    }

    $entries = if ($objects.Data) { $objects.Data } else { $objects }

    $items = [System.Collections.Generic.List[string]]::new()
    foreach ($entry in $entries) {
        if ($entry.PackageIdentifier) {
            $items.Add([string]$entry.PackageIdentifier)
        }
        elseif ($entry.Id) {
            $items.Add([string]$entry.Id)
        }
    }

    if ($items.Count -eq 0) {
        return @{ status = 'ok'; items = @(); error = $null }
    }

    return @{
        status = 'ok'
        items = @($items | Sort-Object -Unique)
        error = $null
    }
}

function Normalize-Name {
    param([string]$Name)

    return $Name.ToLowerInvariant().Trim() -replace '[^a-z0-9]+', ''
}

function Find-Unmatched {
    param(
        [string[]]$Installed,
        [string[]]$CoveredTerms,
        [int]$Max
    )

    $covered = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($term in $CoveredTerms) {
        $normalized = Normalize-Name $term
        if ($normalized) {
            [void]$covered.Add($normalized)
        }
    }

    $unmatched = [System.Collections.Generic.List[string]]::new()
    foreach ($entry in $Installed) {
        if (-not [string]::IsNullOrWhiteSpace($entry)) {
            if (-not $covered.Contains((Normalize-Name $entry))) {
                $unmatched.Add($entry)
            }
        }
    }

    return @($unmatched | Sort-Object -Unique | Select-Object -First $Max)
}

function Match-InstalledAgainstContract {
    param(
        [string[]]$Installed,
        [string[]]$Terms
    )

    if (-not $Installed -or $Installed.Count -eq 0) {
        return @()
    }

    $normalizedInstalled = $Installed | ForEach-Object { Normalize-Name $_ }
    $set = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($entry in $normalizedInstalled) { [void]$set.Add($entry) }

    $hits = [System.Collections.Generic.List[string]]::new()
    foreach ($term in $Terms) {
        $normTerm = Normalize-Name $term
        if ([string]::IsNullOrWhiteSpace($normTerm)) { continue }

        if ($set.Contains($normTerm) -or $set.Contains(($normTerm -replace '-', ''))) {
            $hits.Add($term)
        }
    }

    return @($hits | Sort-Object -Unique)
}

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File | Sort-Object Name | ForEach-Object {
    Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
}

$scoopInventory = Get-ScoopInstalled
$chocoInventory = Get-ChocoInstalled
$wingetInventory = Get-WinGetInstalled

$rows = foreach ($contract in $contracts) {
    $scoopMatches = Match-InstalledAgainstContract -Installed $scoopInventory.items -Terms $contract.duplicate_lookup.scoop_terms
    $chocoMatches = Match-InstalledAgainstContract -Installed $chocoInventory.items -Terms $contract.duplicate_lookup.chocolatey_terms
    $wingetMatches = Match-InstalledAgainstContract -Installed $wingetInventory.items -Terms $contract.duplicate_lookup.winget_terms

    $matchedTerms = @($scoopMatches + $chocoMatches + $wingetMatches | Sort-Object -Unique)

    [pscustomobject]@{
        id              = $contract.id
        name            = $contract.name
        priority        = $contract.priority
        candidate_status = $contract.candidate_status
        scoop           = if ($scoopMatches) { $scoopMatches -join '; ' } else { '-' }
        choco           = if ($chocoMatches) { $chocoMatches -join '; ' } else { '-' }
        winget          = if ($wingetMatches) { $wingetMatches -join '; ' } else { '-' }
        has_match       = [bool]$matchedTerms.Count
    }
}

$signalCount = @($rows | Where-Object { $_.has_match }).Count

$coveredTerms = @()
foreach ($contract in $contracts) {
    $coveredTerms += $contract.duplicate_lookup.scoop_terms
    $coveredTerms += $contract.duplicate_lookup.chocolatey_terms
    $coveredTerms += $contract.duplicate_lookup.winget_terms
}
$coveredTerms = @($coveredTerms | Sort-Object -Unique)

$unmatchedScoop = if ($scoopInventory.status -eq 'ok') { Find-Unmatched -Installed $scoopInventory.items -CoveredTerms $coveredTerms -Max $MaxUnmatched } else { @() }
$unmatchedChoco = if ($chocoInventory.status -eq 'ok') { Find-Unmatched -Installed $chocoInventory.items -CoveredTerms $coveredTerms -Max $MaxUnmatched } else { @() }
$unmatchedWinGet = if ($wingetInventory.status -eq 'ok') { Find-Unmatched -Installed $wingetInventory.items -CoveredTerms $coveredTerms -Max $MaxUnmatched } else { @() }

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# Installed Candidate Signal Review')
$lines.Add('')
$lines.Add("Generated: $((Get-Date).ToUniversalTime().ToString('o'))")
$lines.Add('')
$lines.Add('## Scope')
$lines.Add("- Scoop: $($scoopInventory.status)")
$lines.Add("- Chocolatey: $($chocoInventory.status)")
$lines.Add("- WinGet: $($wingetInventory.status)")
$lines.Add('')
$lines.Add('## Summary')
$lines.Add("- Total contracts checked: $($contracts.Count)")
$lines.Add("- Installed-manager overlap signals: $signalCount")
$lines.Add('')
$lines.Add('| Candidate | Priority | Candidate Status | Scoop signal | Chocolatey signal | WinGet signal |')
$lines.Add('| --- | --- | --- | --- | --- | --- |')
    foreach ($row in $rows | Sort-Object priority, name) {
        $lines.Add("| $($row.name) | $($row.priority) | $($row.candidate_status) | $($row.scoop) | $($row.choco) | $($row.winget) |")
    }

$lines.Add('')
$lines.Add('## Matched Candidates')
$lines.Add('')
if ($signalCount -gt 0) {
    foreach ($row in $rows | Where-Object { $_.has_match } | Sort-Object priority, name) {
        $lines.Add("- $($row.name) ($($row.id))")
    }
}
else {
    $lines.Add('- No installed manager apps currently match candidate contracts.')
}

$lines.Add('')
$lines.Add('## Installed Coverage Gap Candidates')
$lines.Add("- Contracts reviewed: $($contracts.Count)")
$lines.Add('')

if ($scoopInventory.status -eq 'ok' -and @($unmatchedScoop).Count -gt 0) {
    $lines.Add('### Scoop (unmatched to candidate contracts)')
    foreach ($item in $unmatchedScoop) { $lines.Add("- $item") }
    $lines.Add('')
}
if ($chocoInventory.status -eq 'ok' -and @($unmatchedChoco).Count -gt 0) {
    $lines.Add('### Chocolatey (unmatched to candidate contracts)')
    foreach ($item in $unmatchedChoco) { $lines.Add("- $item") }
    $lines.Add('')
}
if ($wingetInventory.status -eq 'ok' -and @($unmatchedWinGet).Count -gt 0) {
    $lines.Add('### WinGet (unmatched to candidate contracts)')
    foreach ($item in $unmatchedWinGet) { $lines.Add("- $item") }
    $lines.Add('')
}

if ((@($unmatchedScoop).Count -eq 0) -and (@($unmatchedChoco).Count -eq 0) -and (@($unmatchedWinGet).Count -eq 0)) {
    $lines.Add('- No unmatched manager entries were available from observed inventories.')
}

$reportDir = Split-Path -Parent $ReportPath
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
$lines | Set-Content -LiteralPath $ReportPath -Encoding Ascii

if ($EmitObject) {
    return [pscustomobject]@{
        contracts = @($rows)
        scoop = $scoopInventory
        choco = $chocoInventory
        winget = $wingetInventory
        matched_count = $signalCount
        unmatched = @{
            scoop = $unmatchedScoop
            chocolatey = $unmatchedChoco
            winget = $unmatchedWinGet
        }
    }
}
