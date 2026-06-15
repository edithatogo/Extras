# Chocolatey Submission: Android Studio

- Contract: android-studio
- Chocolatey package id: androidstudio
- Status: candidate
- Track: conductor/tracks/android_studio_20260613/

## No-Admin Strategy

Use portable or user-scope extraction only; block package route if installer insists on admin context.

## Submission Checklist

- [x] Contract records Chocolatey target posture.
- [x] Machine-scope installer execution is blocked unless separately proven safe.
- [x] Hardening report exists.
- [x] No-admin smoke report exists.
- [ ] Add .nuspec and tools/chocolateyInstall.ps1 only after toolsDir or user-writable runtime validation is proven.

## Current Decision

Candidate remains blocked from hardened completion until extraction/no-admin smoke evidence is attached.
