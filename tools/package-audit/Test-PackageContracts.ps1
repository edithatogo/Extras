param(
    [string]$ContractsPath = (Join-Path $PSScriptRoot '..\..\packaging\contracts'),
    [string]$SchemaPath = (Join-Path $PSScriptRoot '..\..\packaging\contract.schema.json')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Add-Failure {
    param(
        [System.Collections.Generic.List[string]]$Failures,
        [string]$Path,
        [string]$Message
    )

    $Failures.Add("${Path}: $Message")
}

function Test-Property {
    param(
        [object]$Object,
        [string]$Name
    )

    return $null -ne $Object.PSObject.Properties[$Name]
}

function Find-DuplicateJsonProperties {
    param(
        [System.Text.Json.JsonElement]$Element,
        [string]$JsonPath
    )

    $duplicates = [System.Collections.Generic.List[string]]::new()

    if ($Element.ValueKind -eq [System.Text.Json.JsonValueKind]::Object) {
        $names = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
        foreach ($property in $Element.EnumerateObject()) {
            if (-not $names.Add($property.Name)) {
                $duplicates.Add("$JsonPath.$($property.Name)")
            }
            foreach ($duplicate in @(Find-DuplicateJsonProperties -Element $property.Value -JsonPath "$JsonPath.$($property.Name)")) {
                $duplicates.Add($duplicate)
            }
        }
    }
    elseif ($Element.ValueKind -eq [System.Text.Json.JsonValueKind]::Array) {
        $index = 0
        foreach ($item in $Element.EnumerateArray()) {
            foreach ($duplicate in @(Find-DuplicateJsonProperties -Element $item -JsonPath "$JsonPath[$index]")) {
                $duplicates.Add($duplicate)
            }
            $index++
        }
    }

    return @($duplicates)
}

$failures = [System.Collections.Generic.List[string]]::new()
$validContractStatuses = @('candidate', 'blocked', 'covered', 'deferred')
$validTargetStatuses = @('candidate', 'implemented', 'covered', 'blocked', 'deferred')
$validReadinessStates = @('blocked', 'covered', 'implemented', 'deferred', 'candidate-requires-runtime-validation')
$validRuntimeStates = @('passed', 'blocked', 'deferred', 'not-run', 'not-required')
$repoRoot = (Resolve-Path "$PSScriptRoot\..\..").Path

if (-not (Test-Path -LiteralPath $SchemaPath)) {
    throw "Contract schema not found: $SchemaPath"
}

$schema = Get-Content -Raw -LiteralPath $SchemaPath | ConvertFrom-Json
if ($schema.title -ne 'No-admin package contract') {
    throw "Unexpected contract schema: $SchemaPath"
}

$contractFiles = Get-ChildItem -LiteralPath $ContractsPath -Filter '*.json' -File | Sort-Object Name
if (-not $contractFiles) {
    throw "No package contracts found in $ContractsPath"
}

$ids = @{}
foreach ($file in $contractFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    try {
        $document = [System.Text.Json.JsonDocument]::Parse($content)
        $duplicates = Find-DuplicateJsonProperties -Element $document.RootElement -JsonPath '$'
        foreach ($duplicate in $duplicates) {
            Add-Failure $failures $file.FullName "duplicate JSON property '$duplicate'"
        }
        $document.Dispose()
    }
    catch {
        Add-Failure $failures $file.FullName "invalid JSON: $($_.Exception.Message)"
        continue
    }

    try {
        $contract = $content | ConvertFrom-Json
    }
    catch {
        Add-Failure $failures $file.FullName "invalid JSON: $($_.Exception.Message)"
        continue
    }

    foreach ($required in @('schema_version', 'id', 'name', 'priority', 'candidate_status', 'source_policy', 'installer', 'no_admin', 'targets', 'duplicate_lookup', 'ci', 'track', 'readiness')) {
        if (-not (Test-Property $contract $required)) {
            Add-Failure $failures $file.FullName "missing required property '$required'"
        }
    }

    if ((Test-Property $contract 'schema_version') -and $contract.schema_version -ne '1.0') {
        Add-Failure $failures $file.FullName "schema_version must be 1.0"
    }

    if (Test-Property $contract 'id') {
        if ($contract.id -notmatch '^[a-z0-9][a-z0-9-]*$') {
            Add-Failure $failures $file.FullName "id must be kebab-case"
        }
        if ($ids.ContainsKey($contract.id)) {
            Add-Failure $failures $file.FullName "duplicate id also used by $($ids[$contract.id])"
        }
        else {
            $ids[$contract.id] = $file.FullName
        }
    }

    if ((Test-Property $contract 'source_policy') -and $contract.source_policy.public_url_required -ne $true) {
        Add-Failure $failures $file.FullName "source_policy.public_url_required must be true"
    }

    if ((Test-Property $contract 'source_policy') -and $contract.source_policy.local_files_are_evidence_only -ne $true) {
        Add-Failure $failures $file.FullName "source_policy.local_files_are_evidence_only must be true"
    }

    if ((Test-Property $contract 'no_admin') -and $contract.no_admin.required -ne $true) {
        Add-Failure $failures $file.FullName "no_admin.required must be true"
    }

    if ((Test-Property $contract 'no_admin') -and (-not $contract.no_admin.strategy)) {
        Add-Failure $failures $file.FullName "no_admin.strategy is required"
    }

    if ((Test-Property $contract 'no_admin') -and ($contract.no_admin.hard_blockers.Count -lt 1)) {
        Add-Failure $failures $file.FullName "no_admin.hard_blockers must not be empty"
    }

    if (Test-Property $contract 'targets') {
        foreach ($target in @('scoop', 'chocolatey')) {
            if (-not (Test-Property $contract.targets $target)) {
                Add-Failure $failures $file.FullName "targets.$target is required"
                continue
            }

            $targetStatus = $contract.targets.$target.status
            if ($validTargetStatuses -notcontains $targetStatus) {
                Add-Failure $failures $file.FullName "targets.$target.status must be one of $($validTargetStatuses -join ', ')"
            }

            if (-not $contract.targets.$target.no_admin_strategy) {
                Add-Failure $failures $file.FullName "targets.$target.no_admin_strategy is required"
            }
        }
    }

    if ((Test-Property $contract 'candidate_status') -and ($validContractStatuses -notcontains $contract.candidate_status)) {
        Add-Failure $failures $file.FullName "candidate_status must be one of $($validContractStatuses -join ', ')"
    }

    if (Test-Property $contract 'duplicate_lookup') {
        foreach ($termSet in @('scoop_terms', 'chocolatey_terms', 'winget_terms')) {
            if (-not (Test-Property $contract.duplicate_lookup $termSet)) {
                Add-Failure $failures $file.FullName "duplicate_lookup.$termSet is required"
                continue
            }
            if ($contract.duplicate_lookup.$termSet.Count -lt 1) {
                Add-Failure $failures $file.FullName "duplicate_lookup.$termSet must not be empty"
            }
        }
    }

    if ((Test-Property $contract 'ci') -and $contract.ci.require_contract -ne $true) {
        Add-Failure $failures $file.FullName "ci.require_contract must be true"
    }
    if ((Test-Property $contract 'ci') -and $contract.ci.require_no_admin_evidence -ne $true) {
        Add-Failure $failures $file.FullName "ci.require_no_admin_evidence must be true"
    }
    if ((Test-Property $contract 'ci') -and $contract.ci.require_duplicate_lookup -ne $true) {
        Add-Failure $failures $file.FullName "ci.require_duplicate_lookup must be true"
    }

    if (Test-Property $contract 'track') {
        if ($contract.track -notmatch '^conductor/tracks/[A-Za-z0-9_\-]+/$') {
            Add-Failure $failures $file.FullName "track must be a conductor/tracks/*/ relative path"
        }
        elseif (-not (Test-Path -LiteralPath (Join-Path $repoRoot $contract.track))) {
            Add-Failure $failures $file.FullName "track path does not exist: $($contract.track)"
        }
    }

    if (Test-Property $contract 'readiness') {
        foreach ($required in @('state', 'runtime_validation', 'hardening_report', 'smoke_report', 'last_reviewed', 'decision')) {
            if (-not (Test-Property $contract.readiness $required)) {
                Add-Failure $failures $file.FullName "readiness.$required is required"
            }
        }

        if ((Test-Property $contract.readiness 'state') -and ($validReadinessStates -notcontains $contract.readiness.state)) {
            Add-Failure $failures $file.FullName "readiness.state must be one of $($validReadinessStates -join ', ')"
        }

        if ((Test-Property $contract.readiness 'runtime_validation') -and ($validRuntimeStates -notcontains $contract.readiness.runtime_validation)) {
            Add-Failure $failures $file.FullName "readiness.runtime_validation must be one of $($validRuntimeStates -join ', ')"
        }

        if ((Test-Property $contract.readiness 'last_reviewed') -and $contract.readiness.last_reviewed -notmatch '^\d{4}-\d{2}-\d{2}$') {
            Add-Failure $failures $file.FullName "readiness.last_reviewed must be yyyy-mm-dd"
        }

        foreach ($reportField in @('hardening_report', 'smoke_report')) {
            if (Test-Property $contract.readiness $reportField) {
                $reportPath = $contract.readiness.$reportField
                if ($reportPath -notmatch '^packaging/reports/[a-z0-9][a-z0-9-]*-(hardening|noadmin-smoke)\.md$') {
                    Add-Failure $failures $file.FullName "readiness.$reportField must point to packaging/reports/<id>-*.md"
                }
                elseif (-not (Test-Path -LiteralPath (Join-Path $repoRoot $reportPath))) {
                    Add-Failure $failures $file.FullName "readiness.$reportField does not exist: $reportPath"
                }
            }
        }

        if ((Test-Property $contract 'candidate_status') -and $contract.candidate_status -eq 'blocked' -and $contract.readiness.state -ne 'blocked') {
            Add-Failure $failures $file.FullName "blocked candidates must have readiness.state=blocked"
        }

        if ($contract.readiness.state -eq 'implemented' -and $contract.readiness.runtime_validation -ne 'passed') {
            Add-Failure $failures $file.FullName "readiness.state=implemented requires runtime_validation=passed"
        }
    }

    if ((Test-Property $contract 'targets') -and $contract.targets.scoop.status -eq 'implemented') {
        $manifest = $contract.targets.scoop.expected_manifest
        if (-not $manifest) {
            Add-Failure $failures $file.FullName "implemented Scoop target must name expected_manifest"
        }
        elseif (-not (Test-Path -LiteralPath (Join-Path $repoRoot $manifest))) {
            Add-Failure $failures $file.FullName "implemented Scoop manifest does not exist: $manifest"
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated $($contractFiles.Count) package contracts."
