# TightVNC Viewer Hardening Evidence

- Contract: `tightvnc-viewer`
- Track: `conductor/tracks/tightvnc_viewer_20260614/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Article workflow uses a desktop VNC client to connect to droidVNC-NG running on Android.
- The upstream TightVNC MSI can be expanded by Scoop without executing MSI custom actions.
- The viewer-only manifest exposes tvnviewer.exe and does not expose tvnserver.exe.

## No-Admin Strategy
Extract the MSI payload into the Scoop app directory and expose only the viewer binary; do not execute msiexec and do not expose the server/service binary.

## Hard Blockers
- msiexec /i
- server service registration
- HKLM write
- Program Files write
- UAC prompt

## Target Posture
- Scoop: `implemented` - Scoop MSI extraction into app directory with only tvnviewer.exe exposed.
- Chocolatey: `candidate` - Tools-dir MSI extraction only; block any package route that installs the server or invokes msiexec.

## Decision
Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey remains a submission candidate only.
