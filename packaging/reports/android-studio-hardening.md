# Android Studio Hardening Evidence

- Contract: `android-studio`
- Track: `conductor/tracks/android_studio_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `covered`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Bucket manifest already exists at `bucket/android-studio.json`.
- Current manifest uses IDE ZIP extraction to a user-writable folder.

## No-Admin Strategy
Keep ZIP-only manifest flow; avoid installer mode so Android Studio runs as user-level files under Scoop.

## Hard Blockers
- elevated installation workflow
- SDK path rewriting to HKLM

## Target Posture
- Scoop: `implemented` - Scoop zip extraction into app directory; verify no `Start-Process` installer execution path.
- Chocolatey: `candidate` - Use portable or user-scope extraction only; block package route if installer insists on admin context.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
