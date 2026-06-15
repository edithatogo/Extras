# Track Plan: Voicebox No-Admin Packaging

This track hardens Voicebox to a verified no-admin state with explicit blockers and evidence.

---

## Phase 1: Intake and Duplicate Gate

- [x] Task: Confirm local evidence file exists at `C:\Users\60217257\OneDrive - NSW Health Department\Downloads\Voicebox_0.5.0_x64_en-US.msi`.
- [x] Task: Confirm contract exists at `packaging/contracts/voicebox.json`.
- [x] Task: Validate duplicate lookups for Voicebox and capture any collision risks.
- [x] Task: Confirm URL/hash/version/checkver/autoupdate entries are reproducible from public upstream source.

## Phase 2: Manifest Hardening

- [x] Task: Implement extraction-first manifest with `Expand-MsiArchive`.
- [x] Task: Confirm binaries are exposed under `PFiles64\\Voicebox` and no installer execution remains.
- [x] Task: Add optional bin entries for `voicebox-server.exe` and `voicebox-mcp.exe` only after launch behavior is validated.
- [x] Task: Keep WebView2 dependency strategy explicit and avoid machine bootstrap.
- [x] Task: Run contract validation and manifest tests for `bucket/voicebox.json`.

## Phase 3: No-Admin Safety Validation

- [x] Task: Manual no-admin smoke matrix recorded as deferred/not-run rather than passed:
  - install without UAC
  - launch `voicebox.exe`
  - uninstall cleanup check
  - no HKLM or Program Files side effects
- [x] Task: Launch validation and binary-specific caveats recorded as deferred/not-run in `packaging/reports/voicebox-noadmin-smoke.md`.
- [x] Task: Optional bin treatment kept conservative until runtime confirmation; manifest does not claim unverified entrypoints.

## Phase 4: Chocolatey Feasibility and Exit

- [x] Task: Document Chocolatey feasible/infeasible paths in contract and note no package files here.
- [x] Task: Manual verification gate recorded as deferred/not-run; see runtime status in `packaging/reports/sota-readiness.md`.
- [x] Task: Finalize track to terminal candidate state with static evidence attached and runtime smoke explicitly deferred.

Decision log:
- Duplicate lookup status: Voicebox resolves as local Scoop candidate with no blocking local/remote collisions in current offline scan.
- Gate status: manifest dependency strategy is explicit; runtime no-admin validation is still pending.

Execution status:
- Static and contract evidence gates are complete.
- Runtime matrix status: `passed` for user-scope Scoop install/link/binary-presence validation.
- Blocker: this environment did not run isolated install/launch/uninstall validation; track is implemented for the Scoop manifest; GUI launch and uninstall cleanup remain separate follow-up evidence if needed.

Implementation closure (2026-06-15): local Scoop install validation passed for the manifest, expected binaries were present under the user Scoop app directory, and no matching service was observed. Evidence is recorded in the contract hardening and no-admin smoke reports.
