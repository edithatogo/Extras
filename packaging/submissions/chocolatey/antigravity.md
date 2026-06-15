# Antigravity Chocolatey Submission

- Contract: `packaging/contracts/antigravity.json`
- Package source: `packaging/chocolatey/antigravity/`
- Status: package source implemented and `choco pack` validated; isolated extraction/runtime validation pending.
- Source: official Google Antigravity 2.1.4 installer asset used by the community package.
- No-admin posture: portable extraction into `$toolsDir` with data directories kept under package tools.
- Community feed note: `antigravity` exists and is Google Antigravity, but the public install script uses `Install-ChocolateyPackage`, so it is not accepted as hardened no-admin without a separate side-effect proof.

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
