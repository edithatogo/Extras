# Mixxx Scoop Submission

- Contract: `packaging/contracts/mixxx.json`
- Manifest: `bucket/mixxx.json`
- Status: manifest implemented; local install/binary/service smoke passed.
- Source: official Mixxx 2.5.6 Windows MSI from `downloads.mixxx.org`.
- No-admin posture: MSI payload extraction into Scoop's user-writable app directory, no installer custom actions.

## Checklist

- [x] Contract exists.
- [x] Public upstream URL recorded.
- [x] SHA256 recorded.
- [x] Manifest exists.
- [x] Manifest uses extraction-first no-admin strategy.
- [x] Local `scoop install .\bucket\mixxx.json` proof captured.
- [x] Binary presence proof captured.
- [ ] Launch proof captured.
- [ ] Uninstall cleanup proof captured.
- [x] Service side-effect check captured.
- [ ] HKLM, Program Files, and driver side-effect proof captured.
