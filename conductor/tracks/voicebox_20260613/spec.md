# Track Spec: Voicebox No-Admin Packaging

## Goal
Create a hardened no-admin packaging outcome for Voicebox with auditable constraints and known-risk handling.

## Scope
- Scoop target: `bucket/voicebox.json`.
- Contract source: `packaging/contracts/voicebox.json`.
- Optional binaries: `voicebox-server.exe`, `voicebox-mcp.exe` are conditional on launch validation.

## Acceptance Criteria
- Manifest uses extraction-only MSI payload handling and does not invoke MSI custom actions.
- Public source, hash, checkver, and autoupdate values are deterministic and aligned to release tags.
- No-admin behavior is validated for install and uninstall paths (or explicitly blocked if not testable in this environment).
- WebView2 strategy is declared and does not rely on machine-level bootstrap.
- Manual verification protocol completes successfully.

## Evidence Outputs
- `packaging/contracts/voicebox.json`
- `packaging/reports/voicebox-noadmin-smoke.md` (if runtime smoke feasible)
- `packaging/reports/package-existence.md` and `candidate-ranking.md`

## Exit Decision
- If runtime launch requires missing machine prerequisites, move this candidate to blocked-with-rationale and keep manifest draft behavior aligned with documented limitations.
- When all hardening gates pass, close this track as implemented-ready in contract and keep implementation evidence in this folder.
