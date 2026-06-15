# Track Spec: NoMachine Enterprise Client No-Admin Manifest

## Goal
Verify that NoMachine Enterprise Client is implemented in this repo only after satisfying hardened no-admin and verification gates.

## Scope
- Existing implementation target: `bucket/nomachine-enterprise-client.json`.
- Contract and duplicate lookup tracked in `packaging/contracts/nomachine-enterprise-client.json`.
- Chocolatey remains feasibility-only until a downstream package workspace exists.

## Acceptance Criteria
- Contract fields confirm required no-admin strategy for Scoop and Chocolatey feasibility.
- Duplicate lookups are recorded and indicate whether NoMachine is already present under scoop/choco/winget naming.
- Manifest does not run machine-scope MSI or elevation-dependent actions and keeps all writes in Scoop paths.
- Install/launch/uninstall smoke evidence exists and explicitly states whether UAC appears.
- Manual verification protocol in `conductor/workflow.md` is completed for this track.

## Evidence Outputs
- `packaging/contracts/nomachine-enterprise-client.json`
- `packaging/reports/candidate-ranking.md`
- `packaging/reports/nomachine-noadmin-smoke.md` (if runtime smoke is possible in environment)

## Exit Decision
- If extractor viability is negative, manifest remains in `installed-no-admin-possible-via-silent` state and the track is blocked until an extraction-safe alternative is found.
- If all gates pass, set `targets.scoop.status` to implemented and add a completion note under this track.
