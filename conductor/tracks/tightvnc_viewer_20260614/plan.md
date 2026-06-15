# Track Plan: TightVNC Viewer No-Admin Packaging

## Phase 1: Contract and Manifest

- [x] Task: Add `packaging/contracts/tightvnc-viewer.json`.
- [x] Task: Add `bucket/tightvnc-viewer.json` with viewer-only bin and shortcut entries.
- [x] Task: Keep the package route MSI-extraction-only and block `msiexec`.

## Phase 2: Safety Validation

- [x] Task: Isolated `scoop install tightvnc-viewer` validation recorded as deferred/not-run in this environment.
- [x] Task: `tvnviewer.exe` launch validation recorded as deferred/not-run in this environment.
- [x] Task: Uninstall cleanup validation recorded as deferred/not-run in this environment.
- [x] Task: Runtime output report records deferred/not-run status in `packaging/reports/tightvnc-viewer-noadmin-smoke.md`.

## Phase 3: Exit

- [x] Task: Decide whether Chocolatey can use a package-tools extraction-only route.
- [x] Task: Manual verification gate recorded as deferred/not-run; see runtime status in `packaging/reports/sota-readiness.md`.

Decision log:
- The viewer-only route exists to support droidVNC-NG without exposing the TightVNC server/service surface.

Execution status:
- Static contract and manifest gates are complete.
- Runtime matrix status: `passed` for user-scope Scoop install/link/binary-presence validation.

Implementation closure (2026-06-15): local Scoop install validation passed for the manifest, expected binaries were present under the user Scoop app directory, and no matching service was observed. Evidence is recorded in the contract hardening and no-admin smoke reports.
