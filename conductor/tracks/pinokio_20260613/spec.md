# Track Spec: Pinokio No-Admin Packaging

## Goal
Deliver a hardened no-admin Pinokio candidate with auditable evidence in contract, manifest, and verification outputs.

## Scope
- Scoop implementation target: `bucket/pinokio.json`.
- Contract source: `packaging/contracts/pinokio.json`.
- Chocolatey is feasibility-only unless a dedicated Chocolatey package workspace is introduced.

## Acceptance Criteria
- Manifest uses extraction-first (`#/dl.7z` + `Expand-7zipArchive`) and does not execute installer code.
- Hash, checkver, autoupdate entries are stable and align with public upstream source.
- No-manifest/installation evidence confirms no UAC and no HKLM/Program Files writes for install and uninstall.
- Any runtime caveats (for example WebView2) are documented in contract/notes.
- Manual verification protocol in `conductor/workflow.md` is completed.

## Evidence Outputs
- `packaging/contracts/pinokio.json`
- `packaging/reports/pinokio-noadmin-smoke.md` (if runtime smoke is possible)
- `packaging/reports/package-existence.md` and `candidate-ranking.md`

## Exit Decision
- If evidence cannot be collected in this workspace, explicitly mark the track as "blocked: environment dependent" and include next-run steps.
- If all hardening gates pass, transition candidate from requested to implemented readiness in contract metadata.
