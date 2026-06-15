# Track Plan: Quick Share No-Admin Package-Manager Posture

## Phase 1: Discovery
- [x] Task: Record current Scoop manifest and upstream Google MSI source.
- [x] Task: Identify machine-scope install behavior and no-admin hard blockers.
- [x] Task: Add duplicate lookup terms for Scoop, Chocolatey, and WinGet.

## Phase 2: No-Admin Classification
- [x] Task: Mark Scoop no-admin factory route blocked while existing manifest remains machine-scope.
- [x] Task: Mark Chocolatey route blocked unless extraction-only packaging is proven.
- [x] Task: Record Program Files, HKLM, common shortcut, service, and driver blockers.

## Phase 3: Review Closure
- [x] Task: Add package contract under `packaging/contracts/`.
- [x] Task: Remove the machine-scope manifest from this no-admin package-factory branch.
- [x] Task: Keep runtime smoke blocked until a non-executing install route exists.
