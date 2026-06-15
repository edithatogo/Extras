# No-Admin Package Factory Requirements

## Goal
Systematise conversion of high-signal Windows applications into Scoop manifests and Chocolatey package candidates that install without administrator approval.

## MoSCoW Requirements

### Must
- Every package candidate must have a contract in `packaging/contracts/` before implementation.
- Every contract must require no-admin installation and define hard blockers.
- Every candidate must run duplicate lookup across local Scoop buckets, Chocolatey, and WinGet before implementation.
- Every contract must name an owning conductor track and readiness state.
- Every contract must name hardening and no-admin smoke evidence report paths.
- Contract validation must reject duplicate JSON keys.
- Local installer files are evidence only; completed packages must use stable public URLs unless explicitly marked internal-only.
- Scoop implementations must prefer extraction or portable layouts over installer execution.
- Chocolatey implementations must use package-local or user-writable layouts; machine-scope MSI install is blocked.
- Bundled apps with service/server side effects must be split into narrower manifests when the requested workflow only needs a safe client binary.
- CI must validate contracts, generate offline reports, and run existing Scoop tests.
- CI must not require live Chocolatey or WinGet availability for basic validation.
- Feasibility evidence for both Scoop and Chocolatey must include explicit blocker documentation, including:
  - why installer execution cannot be used,
  - how the package will avoid elevation,
  - whether WebView2/runtime bootstrapping is externalized to Scoop.
- CI contract validation must reject missing required `ci` fields and missing no-admin strategy evidence.
- CI must generate a readiness matrix (`packaging/reports/sota-readiness.md`) showing each contract's no-admin candidate state, target statuses, and duplicate lookup signals.
- CI must generate per-contract hardening and no-admin smoke reports before reviewer handoff.
- Implemented Scoop targets must have submission checklists under `packaging/submissions/scoop/`.
- Chocolatey candidate or implemented targets must have submission notes under `packaging/submissions/chocolatey/`.
- Implemented Chocolatey targets must have package source files under `packaging/chocolatey/<package_id>/`, including a `.nuspec` and `tools/chocolateyinstall.ps1`.
- CI submission readiness must statically reject implemented Chocolatey install scripts that invoke admin helpers, machine-scope package installers, Program Files, HKLM, or service registration patterns.
- CI must run `tools/package-audit/Test-NoAdminPackageSources.ps1` to enforce extraction-first, toolsDir-anchored Chocolatey package sources.
- CI must run `tools/package-audit/Test-ChocolateyPackages.ps1` to compile every implemented Chocolatey package source with `choco pack`.
- CI must keep Chocolatey package build outputs in a disposable temp/cache location and must not require committed `.nupkg` artifacts.
- CI must validate submission readiness before reviewer handoff.

### Should
- Use cached lookup results with timestamps so failed live package feeds do not block unrelated PRs.
- Use existing repo patterns for `#/dl.7z`, `Expand-7zipArchive`, `Expand-MsiArchive`, shortcuts, `persist`, and fixed WebView2 runtime handling.
- Generate candidate and duplicate reports for reviewer triage.
- Run a cross-manager installed-app signal audit (Scoop, Chocolatey, WinGet) and store overlap evidence before changing candidate priority.
- Add no-admin smoke tests for changed candidates once manifests/packages exist.
- Add static checks for UAC, HKLM, Program Files, services, drivers, and WebView2 bootstrap behavior.
- Add a label- or dispatch-driven Windows extraction/runtime job for packages whose source download and extraction can be safely run without install side effects.
- Promote installed-app audit candidates into dedicated tracks only after source provenance and duplicate lookup justify implementation.

### Could
- Add online scheduled lookup jobs that refresh cache and open issues for package collisions.
- Add SBOM/provenance generation for Chocolatey package artifacts.
- Add signed release artifact publishing after package contracts and smoke tests pass.
- Add a sandbox VM job for full install/launch/uninstall verification.

### Won't
- Publish packages automatically from this repository in the first factory slice.
- Add Chocolatey package files for candidates that only have track-level feasibility.
- Package enterprise-managed, driver, service, runtime, or system components by default.
- Treat a package as no-admin if it prompts for elevation during install or first launch.

## Acceptance Criteria
- `tools/package-audit/Test-PackageContracts.ps1` exits successfully.
- `tools/package-audit/Test-SubmissionReadiness.ps1` exits successfully.
- `tools/package-audit/Test-NoAdminPackageSources.ps1` exits successfully.
- `tools/package-audit/Test-ChocolateyPackages.ps1` exits successfully.
- Implemented Chocolatey targets fail submission readiness if package-source files are missing or contain blocked machine-scope patterns.
- Implemented Chocolatey targets fail package validation if `choco pack` cannot compile the source.
- `tools/package-audit/Find-Existing.ps1` writes `packaging/cache/package-existence.json` and `packaging/reports/package-existence.md`.
- `tools/package-audit/New-CandidateReport.ps1` writes `packaging/reports/candidate-ranking.md`.
- CI runs the contract validator and offline report generation after the existing Scoop tests.
- The Conductor SOTA track names the package factory docs and tools as the source of truth.
- Every contract points at a conductor track and evidence reports that exist in the repository.
