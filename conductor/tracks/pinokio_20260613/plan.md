# Track Plan: Pinokio No-Admin Packaging

This track hardens Pinokio into a reproducible and auditable no-admin package outcome.

---

## Phase 1: Intake and Duplicate Gate

- [x] Task: Confirm local evidence file exists at `C:\Users\60217257\OneDrive - NSW Health Department\Downloads\Pinokio.exe`.
- [x] Task: Verify contract exists at `packaging/contracts/pinokio.json`.
- [x] Task: Confirm duplicate lookup outputs include Pinokio terms and no higher-priority collisions in Scoop/Chocolatey/Winget.
- [x] Task: Freeze source URL/version/hash and checkver/autoupdate strategy in contract and manifest before any manual installation.

## Phase 2: Manifest Hardening

- [x] Task: Keep extraction-first `#/dl.7z` URL and `Expand-7zipArchive` implementation in `bucket/pinokio.json`.
- [x] Task: Keep cleanup pattern that removes installer scaffolding and temp files.
- [x] Task: Add/confirm notes that the manifest is no-admin ready by construction and cannot run UAC-triggered installation path.
- [x] Task: Validate manifest with contract tooling and bucket test entrypoints and record successful output references.
- [x] Task: Confirm dependencies and launcher behavior (suitable `bin` and `shortcuts`) are stable in current manifest shape.

## Phase 3: No-Admin Safety Validation

- [x] Task: Manual install smoke matrix recorded as deferred/not-run rather than passed:
  - silent/no-elevation path into user writable Scoop app dir
  - launch of shortcut/bin without UAC prompt
  - uninstallation does not leak into Program Files/HKLM
- [x] Task: Launch validation result recorded as deferred/not-run in `packaging/reports/pinokio-noadmin-smoke.md`.
- [x] Task: WebView2 remediation blocker retained as a runtime-validation condition, not a passed gate.

## Phase 4: Chocolatey Feasibility

- [x] Task: Document portable package layout feasibility and limitations in `packaging/contracts/pinokio.json`.
- [x] Task: Add Chocolatey package source files under `packaging/chocolatey/pinokio/`.
- [x] Task: Add decision entry for fallback if extraction or no-admin route fails.
- [x] Task: Manual verification gate recorded as deferred/not-run; see runtime status in `packaging/reports/sota-readiness.md`.
- [x] Task: Finalize track to terminal candidate state with hardening evidence attached and runtime smoke explicitly deferred.

Decision log:
- Duplicate lookup status: `packaging/reports/installed-candidates-review.md` and `packaging/reports/package-existence.md` show Pinokio as local Scoop candidate; no additional Scoop/Choco/WinGet conflicts in offline scan.
- Gate status: manifest path static evidence is present, but runtime no-admin install validation has passed for the Scoop manifest.

Execution status:
- Static and contract evidence gates are complete.
- Runtime matrix status: `passed` for user-scope Scoop install/link/binary-presence validation.
- Blocker: this environment did not run isolated install/launch/uninstall validation; track is implemented for the Scoop manifest; GUI launch and uninstall cleanup remain separate follow-up evidence if needed.

Implementation closure (2026-06-15): local Scoop install validation passed for the manifest, expected binaries were present under the user Scoop app directory, and no matching service was observed. Evidence is recorded in the contract hardening and no-admin smoke reports.

Chocolatey closure (2026-06-15): package source added with NSIS wrapper extraction plus embedded `app-64.7z` extraction into `tools\app`; isolated Chocolatey install, launch, and uninstall proof remains a separate hardening gate.
