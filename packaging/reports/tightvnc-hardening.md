# TightVNC Full Bundle Hardening Evidence

- Contract: `tightvnc`
- Track: `conductor/tracks/tightvnc_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `deferred`
- Runtime validation: `deferred`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Windows VNC client manifest already exists as `bucket/tightvnc.json`.
- Scoop extraction model is used from public upstream MSI URLs; no installer execution is required in this repo.
- Full bundle exposes tvnserver.exe; no-admin hardened path is split to tightvnc-viewer.

## No-Admin Strategy
Defer full-bundle hardening; use viewer-only extraction route unless server/service behavior is explicitly required and validated.

## Hard Blockers
- runtime services started by the vendor installer may still occur for optional server modes
- admin-required driver or helper registration in selected feature sets
- network access prompts during first run

## Target Posture
- Scoop: `deferred` - Existing bundle is not the hardened route because it exposes tvnserver.exe; use tightvnc-viewer for the no-admin droidVNC-NG workflow.
- Chocolatey: `deferred` - Package remains deferred until a reproducible user-writable packaging approach is validated.

## Decision
Full TightVNC bundle is deferred from hardened completion; viewer-only package carries the no-admin desktop-client route.
