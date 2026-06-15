# SCRCPY+ Hardening Evidence

- Contract: `scrcpy-plus`
- Track: `conductor/tracks/scrcpy_plus_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Article method references Frontesque.scrcpy+ package and GitHub release artifacts as a GUI wrapper around SCRCPY.
- No Scoop manifest exists yet in this repository.

## No-Admin Strategy
Defer full implementation until install method and reproducible public artifact are confirmed; do not execute any machine-scope installer path by default.

## Hard Blockers
- missing manifest in this repo
- insufficient public artifact fingerprinting for hash/autoupdate alignment
- installer behavior not yet measured for UAC risk

## Target Posture
- Scoop: `blocked` - No confirmed Scoop-native manifest/package route yet.
- Chocolatey: `candidate` - Evaluate the existing Chocolatey package route for non-admin install; record fallback if it depends on machine-wide bootstrap.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
