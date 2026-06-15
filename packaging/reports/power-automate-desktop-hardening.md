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
- PR #1 review comments required installer/uninstaller/dependency fixes for a system-wide EXE route; that route is rejected for this no-admin factory.

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - Do not add a Scoop manifest that invokes the system-wide Setup.Microsoft.PowerAutomate.exe route; review findings require admin/machine-scope lifecycle handling.
- Chocolatey: `blocked` - Chocolatey package exists but is not accepted as no-admin without proof that it avoids machine scope, services, drivers, and HKLM.

## Decision
Blocked for no-admin hardening. PR #1 comments were addressed by rejecting the machine-scope Setup.Microsoft.PowerAutomate.exe manifest rather than adding admin install/uninstall behavior.
