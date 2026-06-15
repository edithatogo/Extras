# Track Plan: SCRCPY SOTA Closure

This track turns the existing SCRCPY contract into an auditable SOTA state or blocks it with explicit reasons.

## Phase 1: Contract and Coverage Consistency

- [x] Task: Confirm contract exists at `packaging/contracts/scrcpy.json`.
- [x] Task: Resolve no-manifest gap by either adding a Scoop manifest or downgrading contract status to `candidate`/`blocked` with strict rationale.
- [x] Task: Record duplicate lookup results for `scrcpy`, `escrcpy`, and `guiscrcpy` terms.

## Phase 2: No-Admin Gate

- [x] Task: Confirm whether a no-UAC Scoop route exists in the repository for any maintained SCRCPY derivative (`guiscrcpy`, `qtscrcpy`, `escrcpy`).
- [x] Task: Set contract `no_admin.hard_blockers` against unsupported installer or machine-scope behaviors.
- [x] Task: Update contract/track status as covered by existing upstream Scoop route; do not duplicate or claim new installer behavior here.

## Phase 3: Chocolatey Alignment

- [x] Task: Keep Chocolatey guidance explicit in contract and mark blocked/deferred if machine-scope bootstrap appears in current package source.
- [x] Task: Add a final decision matrix row to `packaging/reports/candidate-ranking.md` and `package-existence.md` once status is finalized.

## Phase 4: Exit

- [x] Task: Manual verification gate recorded as covered/deferred; existing Scoop route is preferred and runtime was not re-run here.
- [x] Task: Finalize track with hardening evidence references and blocker resolution.

Decision log:
- No-manifest policy remains active for a unified `scrcpy` contract; coverage is via derivative manifests already in repo (`escrcpy`, `guiscrcpy`, `qtscrcpy`).
- Runtime no-admin matrix is deferred; contract stays candidate with explicit hard blocker set.

Execution status:
- Runtime matrix status: `candidate-requires-runtime-validation` in `packaging/reports/sota-readiness.md`.
- Blocker: this environment did not run isolated install/launch/uninstall validation for this derivative family.
