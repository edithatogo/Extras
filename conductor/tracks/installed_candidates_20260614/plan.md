# Track Plan: Installed-App Package Candidate Triage

## Phase 1: Intake

- [x] Task: Capture installed-manager signals in `packaging/reports/installed-candidates-review.md`.
- [x] Task: Add contracts for high-signal installed candidates.
- [x] Task: Require every installed-candidate contract to point at this conductor track.

## Phase 2: Duplicate and Source Review

- [x] Task: For each candidate, refresh duplicate lookup against local Scoop buckets, Chocolatey, and WinGet.
- [x] Task: Identify stable public source URLs, hash strategy, checkver, and autoupdate path.
- [x] Task: Mark candidates `covered` or `blocked` when upstream package-manager coverage is better than a fork-local package.

## Phase 3: No-Admin Feasibility

- [x] Task: Confirm installer format and whether extraction or current-user install is possible.
- [x] Task: Block any candidate that requires UAC, HKLM, Program Files, services, drivers, or machine runtime bootstrap.
- [x] Task: Promote candidates into dedicated app tracks only after implementation is justified.

Execution status:
- Contracts are audit candidates, not hardened packages.
- Runtime matrix status: `candidate-requires-runtime-validation` for all entries in this lane.
