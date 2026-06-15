# Power Automate Process Mining Hardening Evidence

- Contract: `power-automate-process-mining`
- Track: `conductor/tracks/power_automate_process_mining_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- No local Scoop or confirmed Chocolatey route found for a distinct Process Mining desktop app.

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - No separate Scoop desktop package route found.
- Chocolatey: `blocked` - No separate Chocolatey package route confirmed; process mining is service/web/tenant capability rather than a no-admin desktop package.

## Decision
Blocked because no distinct no-admin desktop package route was identified.
