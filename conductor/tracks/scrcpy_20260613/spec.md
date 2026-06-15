# Track Spec: SCRCPY No-Admin Packaging

## Goal
Set a deterministic decision for SCRCPY as a requested Android-screen mirroring candidate in both Scoop and Chocolatey lanes.

## Scope
- Contract: `packaging/contracts/scrcpy.json`
- Related artifacts: `bucket/escrcpy.json`, `bucket/guiscrcpy.json`, `bucket/qtscrcpy.json`

## Acceptance Criteria
- The contract status matches actual manifest coverage.
- No-manifest or deferred states are explicitly labelled.
- Duplicate lookup data is current and linked in reports.

