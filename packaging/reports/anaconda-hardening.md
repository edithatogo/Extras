# Anaconda Hardening Evidence

- Contract: `anaconda`
- Track: `conductor/tracks/anaconda_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop extras/anaconda3 exists and uses /InstallationType=JustMe /NoRegistry.
- Chocolatey package source added under packaging/chocolatey/anaconda3.

## No-Admin Strategy
Use the upstream package-manager route; do not duplicate package logic locally unless upstream route fails no-admin policy.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `covered` - Use upstream Scoop extras/anaconda3; it passes JustMe, NoRegistry, and user-writable destination arguments.
- Chocolatey: `implemented` - Chocolatey package source runs the official installer in JustMe, NoRegistry mode with destination under $toolsDir.

## Decision
Upstream Scoop remains covered; repo-local Chocolatey package source added, pending isolated current-user install proof.
