# DoublShot Hardening Evidence

- Contract: `doublshot`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Installed under AppData\Local\DoublShot

## No-Admin Strategy
Prefer extractable current-user installer.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write

## Target Posture
- Scoop: `candidate` - Probe upstream installer type and no-admin extraction.
- Chocolatey: `candidate` - Portable package only.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
