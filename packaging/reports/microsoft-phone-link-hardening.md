# Microsoft Phone Link Hardening Evidence

- Contract: `microsoft-phone-link`
- Track: `conductor/tracks/microsoft_phone_link_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Phone Link is primarily a Microsoft Store/UWP experience.
- Not currently available as a stable Scoop-style portable/extractable desktop distribution.

## No-Admin Strategy
Treat as non-factory target for this repo; require external Store-managed path and document explicit blocker in both Scoop and Chocolatey candidates.

## Hard Blockers
- Store-only delivery path
- Microsoft account pairing runtime requirements
- UWP app lifecycle outside Scoop/Chocolatey packaging guarantees

## Target Posture
- Scoop: `blocked` - No supported Scoop implementation without Store/Appx sideload complexity and elevated provisioning behavior.
- Chocolatey: `blocked` - No non-admin Chocolatey path is proven currently; avoid creating wrapper that bypasses Store entitlement and UWP install dependencies.

## Decision
Blocked from Scoop/Chocolatey packaging because Store/UWP entitlement and pairing lifecycle are outside deterministic no-admin package control.
