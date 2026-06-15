---
name: no-admin-packaging-submission
description: Harden Scoop and Chocolatey package candidates to no-admin submission readiness.
---

# No-Admin Packaging Submission

Use this skill when converting Windows app candidates into Scoop manifests or Chocolatey submission candidates that must not require administrator approval.

## Workflow

1. Create or update a contract in `packaging/contracts/`.
2. Create or update the owning Conductor track.
3. Prefer upstream package-manager coverage over local duplication.
4. For Scoop, prefer archives, `#/dl.7z`, native MSI extraction, or current-user installs into `$dir`.
5. For Chocolatey, require `$toolsDir` or another user-writable layout; block machine-scope installer execution.
6. For implemented Chocolatey targets, add `packaging/chocolatey/<package_id>/<package_id>.nuspec` and `packaging/chocolatey/<package_id>/tools/chocolateyinstall.ps1`.
7. Run `choco pack` for implemented Chocolatey package sources and remove generated `.nupkg` artifacts before commit.
8. Run local install validation for implemented Scoop manifests when safe.
9. Generate evidence with `Build-ContractEvidenceReports.ps1` and `Build-SotaReadinessReport.ps1`.
10. Add submission notes under `packaging/submissions/scoop/` or `packaging/submissions/chocolatey/`.
11. Run `Test-PackageContracts.ps1`, `Test-SubmissionReadiness.ps1`, `Test-CiContracts.ps1`, focused Pester tests, and `git diff --check`.

## Blockers

- UAC prompt.
- HKLM writes.
- Program Files writes.
- Service or driver registration.
- Machine runtime bootstrap.
- Unofficial package identity when the requested app is official.
