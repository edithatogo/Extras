# TightVNC Full Bundle Hardening Evidence

- Contract: `tightvnc`
- Track: `conductor/tracks/tightvnc_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `covered`
- Runtime validation: `not-required`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Windows VNC client manifest already exists as `bucket/tightvnc.json`.
- Scoop extraction model is used from public upstream MSI URLs; no installer execution is required in this repo.
- Full bundle exposes tvnserver.exe; no-admin hardened path is split to tightvnc-viewer.

## No-Admin Strategy
Keep the existing Scoop full-bundle manifest available as extraction-only coverage, but use the viewer-only extraction route for hardened no-admin Android mirroring unless server behavior is explicitly required and validated.

## Hard Blockers
- runtime services started by the vendor installer may still occur for optional server modes
- admin-required driver or helper registration in selected feature sets
- network access prompts during first run

## Target Posture
- Scoop: `covered` - Existing Scoop manifest extracts the upstream MSI into the Scoop app directory without executing msiexec. Because it exposes tvnserver.exe, prefer tightvnc-viewer for hardened no-admin droidVNC-NG workflows.
- Chocolatey: `deferred` - Package remains deferred until a reproducible user-writable packaging approach is validated.

## Decision
Scoop full-bundle coverage remains available through bucket/tightvnc.json and is not blocked by Chocolatey deferral. Hardened no-admin desktop-client completion remains carried by tightvnc-viewer.
