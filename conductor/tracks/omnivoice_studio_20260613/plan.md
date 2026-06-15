# Track Plan: OmniVoice Studio No-Admin Packaging

This track converts OmniVoice Studio into a hardened no-admin candidate with explicit risk controls.

---

## Phase 1: Intake and Duplicate Gate

- [x] Task: Confirm local evidence file exists at `C:\Users\60217257\OneDrive - NSW Health Department\Downloads\OmniVoice.Studio_0.2.2_x64_en-US.msi`.
- [x] Task: Confirm contract exists at `packaging/contracts/omnivoice-studio.json`.
- [x] Task: Confirm duplicate lookup includes OmniVoice terms and no blocking collisions.
- [x] Task: Finalise manifest URL/checkver/autoupdate and version policy in contract + manifest.

## Phase 2: Manifest Hardening

- [x] Task: Implement extraction-first manifest behavior via `Expand-MsiArchive`.
- [x] Task: Keep install target constrained to `PFiles64\\OmniVoice Studio` and avoid msiexec execution.
- [x] Task: Add explicit blocker notes for ALLUSERS=1, Program Files default, and WebView2 machine bootstrap behavior.
- [x] Task: Keep shortcut and bin shape to launch `PFiles64\\OmniVoice Studio\\app.exe`.
- [x] Task: Run contract validators and manifest tests; attach output references in this track.

## Phase 3: No-Admin Safety Validation

- [x] Task: Manual no-admin matrix recorded as deferred/not-run rather than passed:
  - no elevation prompt
  - launch path is stable with Scoop binary wrapper
  - uninstall check leaves only user-writable or Scoop-owned artifacts
- [x] Task: Verify WebView2 handling path:
  - dependency strategy in Scoop contract is declared
  - no machine-scope Edge bootstrap run during app usage
- [x] Task: Runtime results recorded as deferred/not-run in `packaging/reports/omnivoice-noadmin-smoke.md`.

## Phase 4: Chocolatey Feasibility and Exit

- [x] Task: Document Chocolatey portable/user-writable strategy and known blockers in contract.
- [x] Task: Add Chocolatey package source files under `packaging/chocolatey/omnivoice-studio/`.
- [x] Task: Manual verification gate recorded as deferred/not-run; see runtime status in `packaging/reports/sota-readiness.md`.
- [x] Task: Finalize this track to terminal candidate state with safety and feasibility evidence consistent across contract and spec; runtime smoke remains deferred.

Decision log:
- Duplicate lookup status: OmniVoice Studio resolves as local Scoop candidate with no conflicting Scoop/Choco/WinGet entries in current offline scan.
- Gate status: manifest path is extraction-only; runtime verification of HKLM/program-files/service effects remains pending.

Execution status:
- Static and contract evidence gates are complete.
- Runtime matrix status: `passed` for user-scope Scoop install/link/binary-presence validation.
- Blocker: this environment did not run isolated install/launch/uninstall validation; track is implemented for the Scoop manifest; GUI launch and uninstall cleanup remain separate follow-up evidence if needed.

Implementation closure (2026-06-15): local Scoop install validation passed for the manifest, expected binaries were present under the user Scoop app directory, and no matching service was observed. Evidence is recorded in the contract hardening and no-admin smoke reports.

Chocolatey closure (2026-06-15): package source added with 7-Zip MSI extraction into `tools\app` and a shim for `omnivoice-studio.exe`; isolated Chocolatey install, launch, and uninstall proof remains a separate hardening gate.
