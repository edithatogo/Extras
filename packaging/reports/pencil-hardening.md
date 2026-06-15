# Pencil Hardening Evidence

- Contract: `pencil`
- Track: `conductor/tracks/pencil_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `covered`
- Runtime validation: `not-required`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop extras/pencil extracts NSIS app payload into Scoop directory.
- Repo-local Chocolatey source is deferred until the upstream installer SHA256 can be verified from a complete trusted artifact.

## No-Admin Strategy
Use the upstream package-manager route; do not duplicate package logic locally unless upstream route fails no-admin policy.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `covered` - Use upstream Scoop extras/pencil for Evolus Pencil; manifest extracts NSIS app payload into Scoop directory.
- Chocolatey: `deferred` - Package source must use SHA256 only and extract the NSIS app payload with 7-Zip into $toolsDir.

## Decision
Upstream Scoop remains covered and is not blocked by Chocolatey deferral. Repo-local Chocolatey packaging remains deferred because the review rejected SHA1 and a complete trusted SHA256 artifact has not yet been verified in this pass.
