# NoMachine Enterprise Client Hardening Evidence

- Contract: `nomachine-enterprise-client`
- Track: `conductor/tracks/nomachine_20260604/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Scoop manifest currently uses a silent NSIS execution with /VERYSILENT and /DIR=$dir
- Manifest is installed in repo as bucket/nomachine-enterprise-client.json
- Client-only components only; server-side components are out of scope

## No-Admin Strategy
Prefer silent current-user install into Scoop app directory. Block if installer requires elevation or writes HKLM/Program Files/service state.

## Hard Blockers
- UAC elevation
- machine-wide install service registration
- HKLM writes
- Program Files write

## Target Posture
- Scoop: `implemented` - Keep using /VERYSILENT + /DIR=$dir and avoid installer actions requiring admin rights.
- Chocolatey: `candidate` - Portable extraction or user-writable tools-only packaging only; machine-scope silent install is blocked.

## Decision
Scoop manifest installs into the user Scoop app directory, creates nxplayer shim/shortcut, exposes nxplayer.exe and nxplayer.bin, and no matching service was observed. Installer creates an HKCU uninstall entry pointing at ProgramData; this is recorded as a residual caveat for Chocolatey and upstream review.
