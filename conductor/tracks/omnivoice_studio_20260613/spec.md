# Track Spec: OmniVoice Studio No-Admin Packaging

## Goal
Harden OmniVoice Studio into a no-admin Scoop candidate with reproducible and auditable completion criteria.

## Scope
- Scoop target: `bucket/omnivoice-studio.json`.
- Contract source: `packaging/contracts/omnivoice-studio.json`.
- No packaged Chocolatey artifacts in this repo.

## Acceptance Criteria
- Manifest avoids running `msiexec` and uses extraction only.
- Installer extraction target is explicit and user-writable.
- No UAC, HKLM writes, or Program Files default writes are expected from normal Scoop install behavior.
- WebView2 behavior is documented and either dependency-provided or deferred with explicit note.
- Manual verification protocol is completed and documented.

## Evidence Outputs
- `packaging/contracts/omnivoice-studio.json`
- `packaging/reports/omnivoice-noadmin-smoke.md` (if runtime smoke feasible)
- `packaging/reports/candidate-ranking.md` and `package-existence.md`

## Exit Decision
- If WebView2 bootstrap or installer side effects cannot be neutralized without admin, track is marked blocked with remediation options.
- If all gates pass, the package candidate can advance toward "implemented" with full no-admin evidence attached.
