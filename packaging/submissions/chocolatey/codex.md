# Codex Chocolatey Submission

- Contract: `packaging/contracts/codex.json`
- Package source: `packaging/chocolatey/codex/`
- Status: package source implemented and `choco pack` validated; isolated command smoke pending.
- Source: official OpenAI Codex GitHub release binaries.
- No-admin posture: direct binary download into `$toolsDir`, shim only.

## Checklist

- [x] Contract exists.
- [x] Public upstream URLs recorded.
- [x] SHA256 values recorded.
- [x] `.nuspec` exists.
- [x] `tools/chocolateyinstall.ps1` exists.
- [x] Static no-admin script guard passes.
- [x] `choco pack` proof captured.
- [ ] Isolated non-admin Chocolatey install proof captured.
- [ ] `codex --version` proof captured.
- [ ] Uninstall cleanup proof captured.
- [ ] HKLM, Program Files, service, and driver side-effect proof captured.
