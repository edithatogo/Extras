# Anaconda Chocolatey Submission

- Contract: `packaging/contracts/anaconda.json`
- Package source: `packaging/chocolatey/anaconda3/`
- Status: package source implemented and `choco pack` validated; isolated runtime validation pending.
- Source: official Anaconda archive installer.
- No-admin posture: official installer with `JustMe`, `NoRegistry`, no PATH mutation, destination under `$toolsDir`.

## Checklist

- [x] Contract exists.
- [x] Public upstream URL recorded.
- [x] SHA256 recorded.
- [x] `.nuspec` exists.
- [x] `tools/chocolateyinstall.ps1` exists.
- [x] Static no-admin script guard passes.
- [x] `choco pack` proof captured.
- [ ] Isolated non-admin Chocolatey install proof captured.
- [ ] Conda/python command proof captured.
- [ ] Uninstall cleanup proof captured.
- [ ] HKLM, Program Files, service, and driver side-effect proof captured.
