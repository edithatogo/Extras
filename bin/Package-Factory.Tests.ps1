#Requires -Modules Pester

Describe "No-admin package factory contracts" {
    BeforeAll {
        $script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
        function Assert-True {
            param(
                [bool] $Condition,
                [string] $Message
            )
            if (-not $Condition) {
                throw $Message
            }
        }

        function Assert-Equal {
            param(
                $Actual,
                $Expected,
                [string] $Message
            )
            if ($Actual -ne $Expected) {
                throw "$Message Actual: $Actual Expected: $Expected"
            }
        }
    }

    It "Validates all package contracts" {
        $script = Join-Path $script:RepoRoot 'tools\package-audit\Test-PackageContracts.ps1'
        $output = & $script 2>&1
        $exitCode = if ($LASTEXITCODE -eq $null) { 0 } else { $LASTEXITCODE }
        Assert-Equal $exitCode 0 "Package contract validation failed. $output"

        $contractCount = (Get-ChildItem -Path (Join-Path $script:RepoRoot 'packaging\contracts') -Filter '*.json' -File | Measure-Object).Count
        Assert-True ($contractCount -gt 0) "Expected at least one package contract."
    }

    It "Regenerates package existence and ranking reports" {
        $findExisting = Join-Path $script:RepoRoot 'tools\package-audit\Find-Existing.ps1'
        $candidateRanking = Join-Path $script:RepoRoot 'packaging\reports\candidate-ranking.md'
        $packageExistence = Join-Path $script:RepoRoot 'packaging\cache\package-existence.json'
        $sotaReadiness = Join-Path $script:RepoRoot 'packaging\reports\sota-readiness.md'
        $newCandidateReport = Join-Path $script:RepoRoot 'tools\package-audit\New-CandidateReport.ps1'
        $buildReadiness = Join-Path $script:RepoRoot 'tools\package-audit\Build-SotaReadinessReport.ps1'
        $buildEvidence = Join-Path $script:RepoRoot 'tools\package-audit\Build-ContractEvidenceReports.ps1'

        & $findExisting | Out-Null
        & $buildEvidence | Out-Null
        & $newCandidateReport | Out-Null
        & $buildReadiness | Out-Null

        Assert-True (Test-Path -LiteralPath $candidateRanking) "Missing candidate ranking report."
        Assert-True (Test-Path -LiteralPath $packageExistence) "Missing package existence cache."
        Assert-True (Test-Path -LiteralPath $sotaReadiness) "Missing SOTA readiness report."
    }

    It "Requires every contract to have track and evidence reports" {
        $contracts = Get-ChildItem -Path (Join-Path $script:RepoRoot 'packaging\contracts') -Filter '*.json' -File |
            ForEach-Object { Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json }

        foreach ($contract in $contracts) {
            Assert-True (Test-Path -LiteralPath (Join-Path $script:RepoRoot $contract.track)) "Missing track path for $($contract.id)."
            Assert-True (Test-Path -LiteralPath (Join-Path $script:RepoRoot $contract.readiness.hardening_report)) "Missing hardening report for $($contract.id)."
            Assert-True (Test-Path -LiteralPath (Join-Path $script:RepoRoot $contract.readiness.smoke_report)) "Missing smoke report for $($contract.id)."
        }
    }

    It "Generates installed-candidate signal report" {
        $installedAudit = Join-Path $script:RepoRoot 'tools\package-audit\Find-InstalledCandidates.ps1'
        $installedReport = Join-Path $script:RepoRoot 'packaging\reports\installed-candidates-review.md'

        & $installedAudit | Out-Null
        Assert-True (Test-Path -LiteralPath $installedReport) "Missing installed-candidate report."
    }
}
