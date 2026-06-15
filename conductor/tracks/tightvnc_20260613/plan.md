# Track Plan: TightVNC No-Admin Packaging

## Phase 1: Contract and Coverage Check

- [x] Task: Confirm contract exists at `packaging/contracts/tightvnc.json`.
- [x] Task: Confirm whether `bucket/tightvnc.json` is used as the production route and whether Scoop install remains user-writable.
- [x] Task: Validate duplicate lookup results for local Scoop/Chocolatey/WinGet terms, including `tightvnc` and `GlavSoft.TightVNC`.

## Phase 2: No-Admin Safety

- [x] Task: Record whether extraction-only install leaves out side-effectful service/driver behavior during normal install path.
- [x] Task: Capture expected manifest status evidence (`scoop` + `expected_manifest`) and no-admin strategy in contract.
- [x] Task: Confirm checkver/autoupdate strategy remains stable and hash-safe after track review.

## Phase 3: Posture and Exit

- [x] Task: Update track decision to implemented or blocked with residual risks explicitly documented.
- [x] Task: Manual verification gate recorded as deferred for full bundle; viewer-only route is tracked separately.

Decision log:
- Duplicate lookup status: local Scoop route exists; duplicate collisions are not currently observed.
- Policy state: Scoop full-bundle route is kept as covered/available despite Chocolatey deferral; hardened no-admin Android mirroring remains assigned to `tightvnc-viewer`.

Execution status:
- Runtime matrix status: `covered` in `packaging/reports/sota-readiness.md` for the full-bundle Scoop route.
- Blocker: service/server behavior is not the hardened route; use `tightvnc-viewer` for no-admin desktop-client completion.
