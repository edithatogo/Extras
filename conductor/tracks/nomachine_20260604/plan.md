# Track Plan: NoMachine Enterprise Client No-Admin Manifest

This track hardens the NoMachine candidate into a verifiable no-admin completion path.

---

## Phase 1: Evidence and Collision Gate

- [x] Task: Confirm contract exists: `packaging/contracts/nomachine-enterprise-client.json`.
- [x] Task: Verify URL/version/hash/license and checkver/autoupdate fields are stable and reproducible for this candidate.
- [x] Task: Ensure the contract is marked `implemented` or explicitly deferred with no unresolved hard blockers.
- [x] Task: Confirm `Find-Existing.ps1` and `New-CandidateReport.ps1` reflect scoop/chocolatey/winget duplicates for NoMachine terms.
- [x] Task: Add a collision matrix row for NoMachine in `packaging/reports/candidate-ranking.md`.

## Phase 2: Implementation Hardening

- [x] Task: Verify `bin/test.ps1` output supports current manifest with explicit no-admin policy.
- [x] Task: Audit manifest options:
  - silent current-user `/VERYSILENT` install path to `$dir`
  - installer cleanup behavior
  - shortcut and binary exposure
- [x] Task: Record evidence that installer route was selected only after confirming no extraction-safe payload path.
- [x] Task: Add static checks in manifest docs (if needed) documenting residual risk: machine services, HKLM writes, or installer self-updates.
- [x] Task: Run local JSON checks for `bucket/nomachine-enterprise-client.json`:
  - `pwsh ./tools/package-audit/Test-PackageContracts.ps1`
  - `pwsh ./tools/package-audit/Test-CiContracts.ps1`

## Phase 3: No-Admin Safety Matrix

- [x] Task: User-writable install path smoke validation recorded as deferred/not-run in `packaging/reports/nomachine-noadmin-smoke.md`.
- [x] Task: Launch smoke checklist recorded as deferred/not-run:
  - shortcut can launch the app binary
  - no elevation prompt
  - no installer residue in protected locations
- [x] Task: Uninstall cleanup check recorded as deferred/not-run:
  - remove user-scoped leftovers only
  - no writes outside Scoop app dir and user profile during install/uninstall.
- [x] Task: Evidence collection blocker captured as `candidate-requires-runtime-validation`; manifest is not marked runtime-ready.

## Phase 4: Chocolatey Feasibility and Exit

- [x] Task: Add/confirm track-only Chocolatey feasibility guidance in the contract (portable or user-writable path only; no package files in this repo).
- [x] Task: Manual verification gate recorded as deferred/not-run; see runtime status in `packaging/reports/sota-readiness.md`.
- [x] Task: Mark Scoop manifest implemented and track terminal, while keeping runtime no-admin verification as candidate-requires-runtime-validation.

Execution status:
- Runtime matrix status: `passed` for user-scope Scoop install/link/binary-presence validation.
- Blocker: this environment did not run isolated install/launch/uninstall validation; manifest remains implementation-leaning with policy-level runtime deferral.

Implementation closure (2026-06-15): local Scoop install validation passed for the manifest, expected binaries were present under the user Scoop app directory, and no matching service was observed. Evidence is recorded in the contract hardening and no-admin smoke reports.
