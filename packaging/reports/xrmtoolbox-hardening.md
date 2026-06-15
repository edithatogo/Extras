# XrmToolBox Hardening Evidence

- Contract: `xrmtoolbox`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Installed via WinGet under AppData\Local\Microsoft\WinGet\Packages

## No-Admin Strategy
Prefer portable or user-writable install layout and block machine-wide installer behavior.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write

## Target Posture
- Scoop: `candidate` - Probe upstream archive or WinGet source for extractable payload.
- Chocolatey: `candidate` - Portable package only.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
