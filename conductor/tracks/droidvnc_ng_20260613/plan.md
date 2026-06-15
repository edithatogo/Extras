# Track Plan: DroidVNC-NG Posture

## Phase 1: Intake

- [x] Task: Confirm contract exists at `packaging/contracts/droidvnc-ng.json`.
- [x] Task: Validate duplicate lookup output confirms no native Scoop package and no stable desktop client in this contract alone.
- [x] Task: Confirm mobile-only artifact type and required Android-side permissions are blockers for Scoop packaging.

## Phase 2: Package Boundary

- [x] Task: Keep this candidate policy-blocked unless a supported desktop companion in this repo is established.
- [x] Task: Keep targets explicit:
  - Scoop: blocked, no manifest
  - Chocolatey: blocked or deferred until user-space client is validated
- [x] Task: Link track decision to article-derived dependency graph (requires VNC client + Android server).

## Phase 3: Exit

- [x] Task: Manual verification gate recorded as blocked; no desktop no-admin package route exists for the Android APK itself.

Decision log:
- Duplicate lookup status: blocked candidate with no local Scoop package and no stable desktop client route.
- Policy state: remains blocked due to mobile-server dependency and no supported UAC-safe local packaging path.

Execution status:
- Runtime matrix status: `blocked` in `packaging/reports/sota-readiness.md`.
- Blocker: this is a mobile-server first workflow, not a standalone Windows client installer.
