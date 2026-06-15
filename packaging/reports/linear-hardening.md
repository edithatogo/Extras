# Linear Hardening Evidence

- Contract: `linear`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- AppData\Local\Programs contains Linear

## No-Admin Strategy
Prefer Electron extraction or user-writable install path.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write

## Target Posture
- Scoop: `candidate` - Probe upstream installer for NSIS/Electron extraction.
- Chocolatey: `candidate` - Portable package only.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
