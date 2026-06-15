# OmniVoice Studio Hardening Evidence

- Contract: `omnivoice-studio`
- Track: `conductor/tracks/omnivoice_studio_20260613/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- public-release: https://github.com/debpalash/OmniVoice-Studio/releases/download/v0.3.5/OmniVoice.Studio_0.3.5_x64_en-US.msi (manifest-source)

## Installer Evidence
- MSI ProductName OmniVoice Studio
- ALLUSERS=1
- extracted payload directory PFiles\OmniVoice Studio
- launch target omnivoice-studio.exe
- custom action downloads and invokes Microsoft Edge WebView2 installer

## No-Admin Strategy
Extract MSI/CAB payload into a user-writable package directory; never execute MSI custom actions.

## Hard Blockers
- msiexec /i
- ALLUSERS=1 execution
- WebView2 machine bootstrap
- Program Files write

## Target Posture
- Scoop: `implemented` - Extract MSI payload into PFiles\OmniVoice Studio; launch PFiles\OmniVoice Studio\omnivoice-studio.exe.
- Chocolatey: `candidate` - Portable extraction under $toolsDir only; block MSI execution.

## Decision
Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey remains a submission candidate only.
