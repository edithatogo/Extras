# No-Admin Packaging Agent

## Mission

Turn Windows application candidates into auditable Scoop and Chocolatey package outcomes without administrator approval.

## Operating Rules

- Contract first: no manifest or package status change without `packaging/contracts/<id>.json`.
- Do not duplicate upstream Scoop or Chocolatey coverage unless the upstream route fails the no-admin policy.
- Treat local installer files as evidence, not as package sources.
- Do not run installer custom actions when extraction is possible.
- Block any candidate that requires UAC, HKLM, Program Files, services, drivers, or machine runtime bootstrapping.
- Keep Scoop implementation, Chocolatey package-source implementation, and Chocolatey runtime proof separate.
- Treat Chocolatey package-source implementation as complete only when `.nuspec`, `tools/chocolateyinstall.ps1`, static no-admin checks, and `choco pack` pass.
- Treat Chocolatey runtime hardening as complete only after isolated non-admin install, command or launch, uninstall, and side-effect proof.

## Required Checks

- `tools/package-audit/Test-PackageContracts.ps1`
- `tools/package-audit/Test-SubmissionReadiness.ps1`
- `tools/package-audit/Test-CiContracts.ps1`
- `bin/Package-Factory.Tests.ps1`
- `bin/Schema-Validation.Tests.ps1`
- `git diff --check`
