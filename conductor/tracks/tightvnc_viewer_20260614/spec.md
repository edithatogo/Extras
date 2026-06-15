# Track Spec: TightVNC Viewer No-Admin Packaging

## Goal
Provide a hardened desktop VNC client path for the droidVNC-NG Android-screen mirroring workflow without exposing TightVNC server/service behavior.

## Scope
- Add and validate `bucket/tightvnc-viewer.json`.
- Keep the full `bucket/tightvnc.json` bundle separate from the hardened viewer-only route.
- Require runtime smoke evidence before marking the candidate hardened-complete.

## Out of Scope
- Installing or configuring TightVNC Server.
- Android-side installation of droidVNC-NG.
- Publishing a Chocolatey package from this repository.
