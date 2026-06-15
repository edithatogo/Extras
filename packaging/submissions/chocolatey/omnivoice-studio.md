# Chocolatey Submission: OmniVoice Studio

- Contract: omnivoice-studio
- Chocolatey package id: omnivoice-studio
- Status: package source implemented; isolated Chocolatey runtime validation pending.
- Track: conductor/tracks/omnivoice_studio_20260613/

## No-Admin Strategy

Download the official GitHub release MSI, extract it with 7-Zip into `$toolsDir\app`, and install a shim only. Do not execute MSI custom actions.

## Submission Checklist

- [x] Contract records Chocolatey target posture.
- [x] Machine-scope installer execution is blocked unless separately proven safe.
- [x] Hardening report exists.
- [x] No-admin smoke report exists.
- [x] `.nuspec` exists.
- [x] `tools/chocolateyinstall.ps1` exists.
- [x] Static no-admin script guard passes.
- [x] `choco pack` proof captured.
- [ ] Isolated non-admin Chocolatey install proof captured.
- [ ] Launch proof captured.
- [ ] Uninstall cleanup proof captured.
- [ ] HKLM, Program Files, service, and driver side-effect proof captured.

## Current Decision

Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey package source is implemented with extraction-only install logic; isolated Chocolatey runtime proof remains pending.
