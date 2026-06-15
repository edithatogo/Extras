# Chocolatey Submission: SCRCPY+

- Contract: scrcpy-plus
- Chocolatey package id: scrcpy-plus
- Status: candidate
- Track: conductor/tracks/scrcpy_plus_20260613/

## No-Admin Strategy

Evaluate the existing Chocolatey package route for non-admin install; record fallback if it depends on machine-wide bootstrap.

## Submission Checklist

- [x] Contract records Chocolatey target posture.
- [x] Machine-scope installer execution is blocked unless separately proven safe.
- [x] Hardening report exists.
- [x] No-admin smoke report exists.
- [ ] Add .nuspec and tools/chocolateyInstall.ps1 only after toolsDir or user-writable runtime validation is proven.

## Current Decision

Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
