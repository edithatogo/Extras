# Contract Validation Run

This document captures the outputs for CI contract validation runs.

## 2026-06-13

- Command: `pwsh ./tools/package-audit/Test-PackageContracts.ps1`
  - Status: pass
  - Output: `Validated 17 package contracts.`
- Command: `pwsh ./tools/package-audit/Test-CiContracts.ps1`
  - Status: pass
  - Output: `Validated CI workflow contracts.`
- Command: `pwsh ./tools/package-audit/Find-Existing.ps1`
  - Status: pass (offline mode)
  - Output: `Wrote packaging/cache/package-existence.json` and `packaging/reports/package-existence.md`.
- Command: `pwsh ./tools/package-audit/New-CandidateReport.ps1`
  - Status: pass
  - Output file: `packaging/reports/candidate-ranking.md`
- Command: `pwsh ./tools/package-audit/Build-SotaReadinessReport.ps1`
  - Status: pass
  - Output file: `packaging/reports/sota-readiness.md`
- Command: `pwsh ./tools/package-audit/Find-InstalledCandidates.ps1`
  - Status: pass
  - Output file: `packaging/reports/installed-candidates-review.md`
- Command: `pwsh ./bin/Package-Factory.Tests.ps1`
  - Status: pass
  - Command scope: validates contracts, candidate/rank/reports, and installed-signal smoke fixtures.
- Executor: `pwsh` in `C:\Users\60217257\repos\scoop-extras-fork`
