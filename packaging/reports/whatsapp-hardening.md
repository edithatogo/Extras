# WhatsApp Official App Hardening Evidence

- Contract: `whatsapp`
- Track: `conductor/tracks/whatsapp_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop buckets did not include WhatsApp.
- No confirmed official Chocolatey route was identified.

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - No local Scoop manifest for official WhatsApp Desktop; avoid unofficial wrappers.
- Chocolatey: `blocked` - No confirmed official Chocolatey route; official app is Store/WinGet oriented and outside this no-admin Scoop/Chocolatey contract.

## Decision
Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.
