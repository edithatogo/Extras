# Chocolatey Submission: scrcpy

- Contract: scrcpy
- Chocolatey package id: scrcpy
- Status: candidate
- Track: conductor/tracks/scrcpy_20260613/

## No-Admin Strategy

Use a package that stages release artifacts under Chocolatey package tools dir only; avoid installer helpers that require machine scope.

## Submission Checklist

- [x] Contract records Chocolatey target posture.
- [x] Machine-scope installer execution is blocked unless separately proven safe.
- [x] Hardening report exists.
- [x] No-admin smoke report exists.
- [ ] Add .nuspec and tools/chocolateyInstall.ps1 only after toolsDir or user-writable runtime validation is proven.

## Current Decision

Covered by Scoop main bucket ZIP-only manifest and adb/platform-tools dependency; do not duplicate in extras unless upstream coverage regresses.
