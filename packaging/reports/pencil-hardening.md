# Pencil Hardening Evidence

- Contract: `pencil`
- Track: `conductor/tracks/pencil_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop extras/pencil extracts NSIS app payload into Scoop directory.
- Chocolatey package source added under packaging/chocolatey/pencil.

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
- Chocolatey: `implemented` - Chocolatey package source extracts the NSIS app payload with 7-Zip into $toolsDir and installs a shim only.

## Decision
Upstream Scoop remains covered; repo-local Chocolatey package source added, pending isolated runtime proof.
