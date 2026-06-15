# Codex Hardening Evidence

- Contract: `codex`
- Track: `conductor/tracks/codex_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop main/codex manifest version 0.139.0 uses direct OpenAI GitHub release binaries.
- Chocolatey package source added under packaging/chocolatey/codex.

## No-Admin Strategy
Use the upstream package-manager route; do not duplicate package logic locally unless upstream route fails no-admin policy.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `covered` - Use upstream Scoop main/codex; direct GitHub release exe shims are user-writable and no local fork manifest is needed.
- Chocolatey: `implemented` - Chocolatey package source downloads OpenAI Codex release binaries directly into $toolsDir and installs a shim only.

## Decision
Upstream Scoop remains covered; repo-local Chocolatey package source added, pending isolated install and command smoke proof.
