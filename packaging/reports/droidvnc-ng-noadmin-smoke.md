# droidVNC-NG No-Admin Smoke Evidence

- Contract: `droidvnc-ng`
- Track: `conductor/tracks/droidvnc_ng_20260613/`
- Last reviewed: 2026-06-14
- Runtime validation: `blocked`

| Gate | Status | Evidence |
| --- | --- | --- |
| Install without UAC | blocked | Contract is blocked by package-boundary or policy constraints. |
| Launch primary binary | blocked | No supported desktop package route is approved. |
| Uninstall cleanup | blocked | No install route is approved. |
| No HKLM/Program Files/service side effects | blocked | Blockers are listed in the hardening report. |

## Exit Rule
A candidate is not hardened-complete until all smoke gates pass in an isolated user-scope install, launch, and uninstall run.
