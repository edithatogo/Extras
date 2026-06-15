param(
    [string]$WorkflowPath = (Join-Path $PSScriptRoot '..\..\.github\workflows')
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

$failures = [System.Collections.Generic.List[string]]::new()
$workflowFiles = Get-ChildItem -LiteralPath $WorkflowPath -Filter '*.yml' -File

foreach ($file in $workflowFiles) {
    $content = Get-Content -Raw -LiteralPath $file.FullName

    if ($file.Name -eq 'ci.yml' -and $content -notmatch '(?m)^permissions:\s*\r?\n\s+contents:\s+read\s*$') {
        $failures.Add("$($file.Name): CI workflow must declare least-privilege contents: read permissions")
    }

    if ($file.Name -eq 'ci.yml') {
        foreach ($requiredScript in @(
            'Test-PackageContracts.ps1',
            'Test-SubmissionReadiness.ps1',
            'Test-NoAdminPackageSources.ps1',
            'Test-ChocolateyPackages.ps1',
            'Test-CiContracts.ps1'
        )) {
            if ($content -notmatch [regex]::Escape($requiredScript)) {
                $failures.Add("$($file.Name): CI workflow must run $requiredScript")
            }
        }
    }

    foreach ($match in [regex]::Matches($content, 'uses:\s*([^\s#]+)')) {
        $uses = $match.Groups[1].Value
        if ($uses -match '^(actions/|potatoqualitee/)' -and $uses -notmatch '@[a-f0-9]{40}$') {
            $failures.Add("$($file.Name): action is not pinned to a full SHA: $uses")
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated CI workflow contracts."
