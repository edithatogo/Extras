# EndNote Hardening Evidence

- Contract: `endnote`
- Track: `conductor/tracks/endnote_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local registry shows EndNote 2025 installed under Program Files (x86).
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
- Scoop: `blocked` - No local Scoop route found; commercial/licensed installer is machine-scope in current local install.
- Chocolatey: `blocked` - No confirmed public Chocolatey package route; do not package licensed installer without entitlement and no-admin evidence.

## Decision
Blocked for no-admin package-manager treatment due licensing and machine-scope installer posture.
