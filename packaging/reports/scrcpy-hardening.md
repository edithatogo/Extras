# scrcpy Hardening Evidence

- Contract: `scrcpy`
- Track: `conductor/tracks/scrcpy_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `covered`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Official Windows release zip includes `scrcpy.exe`, adb helper files, and server payload.
- No installer stub is used; manifest-level archive extraction is sufficient.
- Existing Scoop coverage is via `bucket/escrcpy.json`, `bucket/guiscrcpy.json`, and `bucket/qtscrcpy.json`; this contract tracks the scrcpy family.
- Local Scoop main bucket contains scrcpy.json with ZIP-only extraction and no installer execution.

## No-Admin Strategy
Use Scoop main bucket scrcpy ZIP extraction and adb/platform-tools dependency; no local extras manifest is required unless upstream coverage regresses.

## Hard Blockers
- installer-based write path to Program Files
- service/driver install attempts
- elevated first-run requirements

## Target Posture
- Scoop: `covered` - Covered by local Scoop main bucket manifest scrcpy.json using official ZIP extraction; avoid duplicating in extras.
- Chocolatey: `candidate` - Use a package that stages release artifacts under Chocolatey package tools dir only; avoid installer helpers that require machine scope.

## Decision
Covered by Scoop main bucket ZIP-only manifest and adb/platform-tools dependency; do not duplicate in extras unless upstream coverage regresses.
