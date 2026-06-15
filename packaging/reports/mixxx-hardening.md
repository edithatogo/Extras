# Mixxx Hardening Evidence

- Contract: `mixxx`
- Track: `conductor/tracks/mixxx_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `implemented`
- Runtime validation: `passed`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Official Mixxx download page lists stable 2.5.6 Windows MSI from downloads.mixxx.org.
- SHA256 from official Mixxx download page is 0d1f01a1f5c2e4d4180cd462e60365d0230b405808e7bd2b6625b62a53a29c72.
- Local Scoop install passed on 2026-06-15; Mixxx\\mixxx.exe and shim exist.
- No matching Mixxx Windows service observed after Scoop install.
- Chocolatey package source added under packaging/chocolatey/mixxx and choco pack succeeded.

## No-Admin Strategy
Use the official stable Windows MSI as source material. Scoop and Chocolatey routes extract into user-writable package directories and avoid installer custom actions where possible.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `implemented` - MSI payload extraction into Scoop user directory; installer custom actions are skipped.
- Chocolatey: `implemented` - Chocolatey package source uses MSI administrative extraction into $toolsDir and installs a shim only.

## Decision
Scoop manifest installed successfully from official Mixxx 2.5.6 MSI, binary and shim exist, and no matching service was observed. Chocolatey package source compiles with choco pack but isolated Chocolatey install proof remains pending.
