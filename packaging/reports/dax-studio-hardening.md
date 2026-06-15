# DAX Studio Hardening Evidence

- Contract: `dax-studio`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Installed per-user under AppData\Local\Programs\DAX Studio

## No-Admin Strategy
Prefer upstream per-user installer or extractable payload; reject machine-scope MSI execution.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write

## Target Posture
- Scoop: `candidate` - Probe upstream installer for silent current-user mode or extraction.
- Chocolatey: `candidate` - Portable or current-user install only.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
