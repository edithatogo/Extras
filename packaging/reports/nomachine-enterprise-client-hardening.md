# NoMachine Enterprise Client Hardening Evidence

- Contract: `nomachine-enterprise-client`
- Track: `conductor/tracks/nomachine_20260604/`
- Last reviewed: 2026-06-15
- Readiness state: `deferred`
- Runtime validation: `deferred`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Previous Scoop manifest route used a silent NSIS execution with /VERYSILENT and /DIR=$dir
- Direct installer execution is deferred until a pure extraction route is proven
- Client-only components only; server-side components are out of scope

## No-Admin Strategy
Use only a proven extraction route into a user-writable package directory. Direct installer execution is blocked for no-admin submission.

## Hard Blockers
- UAC elevation
- machine-wide install service registration
- HKLM writes
- Program Files write

## Target Posture
- Scoop: `deferred` - Prove installer extraction without execution before adding a Scoop manifest.
- Chocolatey: `candidate` - Portable extraction or user-writable tools-only packaging only; machine-scope silent install is blocked.

## Decision
Previous local smoke showed a user-directory install and no matching service, but the route executed the vendor installer and created an HKCU uninstall entry pointing at ProgramData. Submission is deferred until a non-executing extraction strategy is proven.
