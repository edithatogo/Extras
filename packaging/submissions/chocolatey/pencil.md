# Pencil Chocolatey Submission

- Contract: `packaging/contracts/pencil.json`
- Package source: `packaging/chocolatey/pencil/`
- Status: package source implemented and `choco pack` validated; isolated runtime validation pending.
- Source: official Evolus Pencil NSIS installer.
- No-admin posture: 7-Zip extraction of NSIS app payload into `$toolsDir`, shim only, no installer execution.

## Checklist

- [x] Contract exists.
- [x] Public upstream URL recorded.
- [x] SHA1 recorded from upstream Scoop manifest.
- [x] `.nuspec` exists.
- [x] `tools/chocolateyinstall.ps1` exists.
- [x] Static no-admin script guard passes.
- [x] `choco pack` proof captured.
- [ ] Isolated non-admin Chocolatey install proof captured.
- [ ] Launch proof captured.
- [ ] Uninstall cleanup proof captured.
- [ ] HKLM, Program Files, service, and driver side-effect proof captured.
