# Antigravity Hardening Evidence

- Contract: `antigravity`
- Track: `conductor/tracks/antigravity_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Chocolatey community package antigravity 2.1.4 is Google Antigravity but uses Install-ChocolateyPackage to execute the installer.
- Local Chocolatey package source added under packaging/chocolatey/antigravity with the same official 2.1.4 artifact and an extraction-first no-admin strategy.

## No-Admin Strategy
Use the upstream package-manager route; do not duplicate package logic locally unless upstream route fails no-admin policy.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `covered` - Use upstream Scoop extras/antigravity, extras/antigravity-ide, or main/antigravity-cli as appropriate; avoid duplicate local manifests.
- Chocolatey: `implemented` - Chocolatey package source downloads the official Google Antigravity 2.1.4 artifact and attempts portable extraction into $toolsDir; community package exists but executes the installer.

## Decision
Chocolatey package identity is covered by the community feed, but the community install script executes the installer. Repo-local extraction-first package source added, pending extraction and runtime proof.
