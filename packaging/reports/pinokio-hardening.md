# Pinokio Hardening Evidence

- Contract: `pinokio`
- Track: `conductor/tracks/pinokio_20260613/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- local-evidence: C:\Users\60217257\OneDrive - NSW Health Department\Downloads\Pinokio.exe (evidence-only)

## Installer Evidence
- NSIS-3 Unicode installer
- contains $PLUGINSDIR\app-64.7z
- inner archive contains Pinokio.exe

## No-Admin Strategy
Extract the NSIS payload and expand app-64.7z into the Scoop app directory; do not execute the installer.

## Hard Blockers
- UAC prompt
- machine-wide install
- Program Files write
- HKLM write

## Target Posture
- Scoop: `implemented` - Use #/dl.7z and Expand-7zipArchive on $PLUGINSDIR\app-64.7z.
- Chocolatey: `candidate` - Portable package under $toolsDir only; do not run installer.

## Decision
Scoop manifest installs into user-scope Scoop, creates expected shims/shortcuts, exposes expected binaries, and no matching Windows service or uninstall registry entry was observed during local validation. Chocolatey remains a submission candidate only.
