# Linear No-Admin Smoke Evidence

- Contract: `linear`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Runtime validation: `not-run`

| Gate | Status | Evidence |
| --- | --- | --- |
| Install without UAC | not-run | Isolated runtime validation has not been executed. |
| Launch primary binary | not-run | Isolated runtime validation has not been executed. |
| Uninstall cleanup | not-run | Isolated runtime validation has not been executed. |
| No HKLM/Program Files/service side effects | not-run | Isolated runtime validation has not been executed. |

## Exit Rule
A candidate is not hardened-complete until all smoke gates pass in an isolated user-scope install, launch, and uninstall run.
