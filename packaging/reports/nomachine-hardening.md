# NoMachine Enterprise Client Hardening

- [x] No UAC install path documented (`Start-Process` install route currently requires runtime checks against `/DIR=$dir` behavior).
- [ ] No HKLM writes confirmed (runtime verification deferred pending isolated user-scope run).
- [ ] No Program Files writes confirmed (runtime verification deferred pending isolated user-scope run).
- [ ] No service/driver side effects confirmed (runtime verification deferred pending isolated user-scope run).
- [x] Stable upstream source metadata confirmed (`9.6.3` download source, hash, `checkver`, `autoupdate`).
- [x] Linkage to manifest and contract fields verified (`bucket/nomachine-enterprise-client.json` ↔ `packaging/contracts/nomachine-enterprise-client.json`).
