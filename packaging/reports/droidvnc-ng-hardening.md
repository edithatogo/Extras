# droidVNC-NG Hardening Evidence

- Contract: `droidvnc-ng`
- Track: `conductor/tracks/droidvnc_ng_20260613/`
- Last reviewed: 2026-06-14
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- droidVNC-NG is an Android-side VNC server app (APK distribution).
- This repo currently tracks desktop packaging; no native desktop installer exists in the upstream project.

## No-Admin Strategy
Block as non-desktop package in this factory lane; provide only tracking + duplicate lookup evidence and defer until a verifiable desktop-side alternative exists.

## Hard Blockers
- mobile APK-only artifact
- no standalone Windows installer
- requires Android-side permissions and screen-access service

## Target Posture
- Scoop: `blocked` - No Scoop-ready desktop installer; maintain as policy decision not to package.
- Chocolatey: `blocked` - No verified Chocolatey implementation path without elevating through unsupported mobile provisioning.

## Decision
Blocked as a mobile APK/server workflow; desktop packaging lane is TightVNC viewer/client coverage only.
