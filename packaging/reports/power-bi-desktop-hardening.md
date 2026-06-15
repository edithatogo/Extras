# Power BI Desktop Hardening Evidence

- Contract: `power-bi-desktop`
- Track: `conductor/tracks/power_bi_desktop_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop buckets did not include Power BI Desktop.
- Registry showed related Bravo for Power BI only, not Power BI Desktop.
- PR #2 review comments required install-location, uninstaller, shortcut, and autoupdate fixes for a system-wide EXE route; that route is rejected for this no-admin factory.

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - Do not add a Scoop manifest that invokes PBIDesktopSetup as a managed system installer; review findings require machine-scope lifecycle handling and do not satisfy no-admin packaging.
- Chocolatey: `blocked` - No confirmed no-admin Chocolatey route; block until user-scoped installer evidence exists.

## Decision
Blocked for no-admin Scoop/Chocolatey packaging. PR #2 comments were addressed by rejecting the PBIDesktopSetup system-installer manifest rather than adding admin install/uninstall behavior.
