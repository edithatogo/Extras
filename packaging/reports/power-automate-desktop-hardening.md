# Power Automate Desktop Hardening Evidence

- Contract: `power-automate-desktop`
- Track: `conductor/tracks/power_automate_desktop_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Chocolatey community package powerautomatedesktop exists.
- No local Scoop manifest found.

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - No local Scoop bucket route found; desktop automation installs commonly require machine components and admin approval.
- Chocolatey: `blocked` - Chocolatey package exists but is not accepted as no-admin without proof that it avoids machine scope, services, drivers, and HKLM.

## Decision
Blocked for no-admin hardening until isolated evidence proves a user-scope install with no machine side effects.
