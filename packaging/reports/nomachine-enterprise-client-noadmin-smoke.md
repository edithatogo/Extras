# NoMachine Enterprise Client No-Admin Smoke Evidence

- Contract: `nomachine-enterprise-client`
- Track: `conductor/tracks/nomachine_20260604/`
- Last reviewed: 2026-06-15
- Runtime validation: `deferred`

| Gate | Status | Evidence |
| --- | --- | --- |
| Install without UAC | not-run | Isolated runtime validation has not been executed. |
| Launch primary binary | not-run | Isolated runtime validation has not been executed. |
| Uninstall cleanup | not-run | Isolated runtime validation has not been executed. |
| No HKLM/Program Files/service side effects | not-run | Isolated runtime validation has not been executed. |

## Exit Rule
A candidate is not hardened-complete until all smoke gates pass in an isolated user-scope install, launch, and uninstall run.
