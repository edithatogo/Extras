param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$CachePath = (Join-Path $PSScriptRoot '..\..\packaging\cache\package-existence.json'),
    [string]$ReportPath = (Join-Path $PSScriptRoot '..\..\packaging\reports\package-existence.md'),
    [switch]$Online,
    [switch]$UseCache,
    [switch]$DeepLocalScan
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function ConvertTo-RelativePath {
    param([string]$Path)

    $root = (Resolve-Path "$PSScriptRoot\..\..").Path
    if ($Path.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $Path.Substring($root.Length).TrimStart('\', '/')
    }
    return $Path
}

function New-LocalScoopIndex {
    $roots = @()
    $repoBucket = Join-Path (Resolve-Path "$PSScriptRoot\..\..") 'bucket'
    if (Test-Path -LiteralPath $repoBucket) {
        $roots += $repoBucket
    }
    $userBuckets = Join-Path $env:USERPROFILE 'scoop\buckets'
    if (Test-Path -LiteralPath $userBuckets) {
        $roots += Get-ChildItem -LiteralPath $userBuckets -Directory | ForEach-Object { Join-Path $_.FullName 'bucket' }
    }

    $index = [System.Collections.Generic.List[object]]::new()
    foreach ($root in $roots | Where-Object { Test-Path -LiteralPath $_ }) {
        foreach ($file in Get-ChildItem -LiteralPath $root -Filter '*.json' -File -ErrorAction SilentlyContinue) {
            $haystack = $file.BaseName
            if ($DeepLocalScan) {
                $haystack = "$haystack`n$(Get-Content -Raw -LiteralPath $file.FullName)"
            }
            $index.Add([pscustomobject]@{
                Path = (ConvertTo-RelativePath $file.FullName)
                Haystack = $haystack
            })
        }
    }

    return @($index)
}

function Find-LocalScoopMatches {
    param(
        [object[]]$Index,
        [string[]]$Terms
    )

    $matches = [System.Collections.Generic.List[string]]::new()
    foreach ($item in $Index) {
        foreach ($term in $Terms) {
            if ($item.Haystack.IndexOf($term, [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
                $matches.Add($item.Path)
                break
            }
        }
    }

    return @($matches | Sort-Object -Unique)
}

function Find-LocalScoopMatchesSlow {
    param([string[]]$Terms)

    $index = New-LocalScoopIndex
    return Find-LocalScoopMatches -Index $index -Terms $Terms
}

function Invoke-OptionalLookup {
    param(
        [string]$Name,
        [string[]]$Terms,
        [scriptblock]$Lookup
    )

    if (-not $Online) {
        return [pscustomobject]@{
            status  = 'skipped-offline'
            results = @()
            error   = $null
        }
    }

    try {
        $results = @(& $Lookup $Terms)
        return [pscustomobject]@{
            status  = 'ok'
            results = @($results | Where-Object { $_ } | Sort-Object -Unique)
            error   = $null
        }
    }
    catch {
        return [pscustomobject]@{
            status  = 'failed'
            results = @()
            error   = "$Name lookup failed: $($_.Exception.Message)"
        }
    }
}

if ($UseCache -and (Test-Path -LiteralPath $CachePath)) {
    $cached = Get-Content -Raw -LiteralPath $CachePath | ConvertFrom-Json
    Write-Output $cached
    return
}

$contracts = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File | Sort-Object Name | ForEach-Object {
    Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
}

$localScoopIndex = New-LocalScoopIndex

$results = foreach ($contract in $contracts) {
    $localScoop = Find-LocalScoopMatches -Index $localScoopIndex -Terms $contract.duplicate_lookup.scoop_terms

    $chocolatey = Invoke-OptionalLookup -Name 'Chocolatey' -Terms $contract.duplicate_lookup.chocolatey_terms -Lookup {
        param($terms)
        foreach ($term in $terms) {
            choco search $term --limit-output --exact 2>$null
        }
    }

    $winget = Invoke-OptionalLookup -Name 'WinGet' -Terms $contract.duplicate_lookup.winget_terms -Lookup {
        param($terms)
        foreach ($term in $terms) {
            winget search --exact --name $term --disable-interactivity 2>$null
        }
    }

    [pscustomobject]@{
        id          = $contract.id
        name        = $contract.name
        priority    = $contract.priority
        local_scoop = [pscustomobject]@{
            status  = 'ok'
            results = @($localScoop)
        }
        chocolatey  = $chocolatey
        winget      = $winget
    }
}

$payload = [pscustomobject]@{
    generated_at = (Get-Date).ToUniversalTime().ToString('o')
    online       = [bool]$Online
    deep_local_scan = [bool]$DeepLocalScan
    contracts    = @($results)
}

$cacheDir = Split-Path -Parent $CachePath
$reportDir = Split-Path -Parent $ReportPath
New-Item -ItemType Directory -Force -Path $cacheDir, $reportDir | Out-Null
$payload | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $CachePath -Encoding Ascii

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# Package Existence Report')
$lines.Add('')
$lines.Add("Generated: $($payload.generated_at)")
$lines.Add("Online lookups: $($payload.online)")
$lines.Add("Deep local scan: $($payload.deep_local_scan)")
$lines.Add('')
$lines.Add('| Candidate | Priority | Local Scoop Matches | Chocolatey | WinGet |')
$lines.Add('| --- | --- | --- | --- | --- |')
foreach ($item in $payload.contracts) {
    $scoop = if ($item.local_scoop.results.Count) { ($item.local_scoop.results -join '<br>') } else { 'none' }
    $choco = if ($item.chocolatey.status -eq 'ok' -and $item.chocolatey.results.Count) { ($item.chocolatey.results -join '<br>') } else { $item.chocolatey.status }
    $winget = if ($item.winget.status -eq 'ok' -and $item.winget.results.Count) { ($item.winget.results -join '<br>') } else { $item.winget.status }
    $lines.Add("| $($item.name) | $($item.priority) | $scoop | $choco | $winget |")
}
$lines | Set-Content -LiteralPath $ReportPath -Encoding Ascii

$payload | ConvertTo-Json -Depth 8
