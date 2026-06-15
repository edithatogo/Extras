# Power Platform ToolBox Hardening Evidence

- Contract: `power-platform-toolbox`
- Track: `conductor/tracks/installed_candidates_20260614/`
- Last reviewed: 2026-06-14
- Readiness state: `candidate-requires-runtime-validation`
- Runtime validation: `not-run`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Installed current-user under AppData\Local\Programs

## No-Admin Strategy
Prefer extractable current-user installer; block machine-scope install.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write

## Target Posture
- Scoop: `candidate` - Probe upstream source for extractable or current-user payload.
- Chocolatey: `candidate` - Portable package only.

## Decision
Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
