# Voicebox Hardening Evidence

- Contract: `voicebox`
- Track: `conductor/tracks/voicebox_20260613/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- public-release: https://github.com/jamiepine/voicebox/releases/download/v0.5.0/Voicebox_0.5.0_x64_en-US.msi (manifest-source)

## Installer Evidence
- MSI ProductName Voicebox
- ALLUSERS=1
- target directory ProgramFiles64Folder\Voicebox
- launch target voicebox.exe
- contains voicebox-server.exe and voicebox-mcp.exe
- custom action downloads and invokes Microsoft Edge WebView2 installer

## No-Admin Strategy
Extract MSI/CAB payload into a user-writable package directory; never execute MSI custom actions.

## Hard Blockers
- msiexec /i
- ALLUSERS=1 execution
- WebView2 machine bootstrap
- Program Files write

## Target Posture
- Scoop: `implemented` - Extract MSI payload; shortcut voicebox.exe; evaluate server and MCP binaries as optional bins.
- Chocolatey: `candidate` - Portable extraction under $toolsDir only; block MSI execution.

## Decision
Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey remains a submission candidate only.
