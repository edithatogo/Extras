# Mixxx Chocolatey Submission

- Contract: `packaging/contracts/mixxx.json`
- Package source: `packaging/chocolatey/mixxx/`
- Status: package source implemented and `choco pack` validated; isolated runtime validation pending.
- Source: official Mixxx 2.5.6 Windows MSI from `downloads.mixxx.org`.
- No-admin posture: MSI administrative extraction into `$toolsDir`, shim only, no installer custom actions.

## Checklist

- [x] Contract exists.
- [x] Public upstream URL recorded.
- [x] SHA256 recorded.
- [x] `.nuspec` exists.
- [x] `tools/chocolateyinstall.ps1` exists.
- [x] Static no-admin script guard passes.
- [x] `choco pack` proof captured.
- [ ] Isolated non-admin Chocolatey install proof captured.
- [ ] Launch proof captured.
- [ ] Uninstall cleanup proof captured.
- [ ] HKLM, Program Files, service, and driver side-effect proof captured.
