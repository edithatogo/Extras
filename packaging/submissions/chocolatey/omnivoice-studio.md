# Chocolatey Submission: OmniVoice Studio

- Contract: omnivoice-studio
- Chocolatey package id: omnivoice-studio
- Status: candidate
- Track: conductor/tracks/omnivoice_studio_20260613/

## No-Admin Strategy

Portable extraction under $toolsDir only; block MSI execution.

## Submission Checklist

- [x] Contract records Chocolatey target posture.
- [x] Machine-scope installer execution is blocked unless separately proven safe.
- [x] Hardening report exists.
- [x] No-admin smoke report exists.
- [ ] Add .nuspec and tools/chocolateyInstall.ps1 only after toolsDir or user-writable runtime validation is proven.

## Current Decision

Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey remains a submission candidate only.
