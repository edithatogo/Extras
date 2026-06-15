# Track Plan: Mixxx No-Admin Package-Manager Posture

## Phase 1: Discovery
- [x] Task: Check local Scoop bucket manifests and installed app state.
- [x] Task: Check Chocolatey availability where local or web sources were available.
- [x] Task: Record duplicate/package identity risks.

## Phase 2: No-Admin Classification
- [x] Task: Classify Scoop route as covered, candidate, deferred, or blocked.
- [x] Task: Classify Chocolatey route as covered, candidate, deferred, or blocked.
- [x] Task: Reject unofficial, ambiguous, or machine-scope routes for hardened no-admin use.

## Phase 3: Implementation
- [x] Task: Add or update package contract under `packaging/contracts/`.
- [x] Task: Generate hardening and no-admin smoke evidence report paths.
- [x] Task: Keep this track terminal without claiming runtime smoke where runtime was not executed.

Execution status:
- Contract status: $(@{Id=mixxx; Name=Mixxx; Version=; Track=mixxx_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No local Scoop manifest found; do not add one until stable upstream archive/installer extraction and current-user smoke evidence are captured.; Choco=deferred; ChocoId=mixxx; ChocoStrategy=Chocolatey mixxx package exists, but current visible package is alpha; defer as SOTA install source for hardened no-admin use.; Evidence=System.Object[]; Decision=Deferred after cleanup; package route needs stable release source and isolated no-admin smoke before hardening.; Desc=Track Mixxx packaging feasibility after local cleanup.}.Status).
- Readiness state: $(@{Id=mixxx; Name=Mixxx; Version=; Track=mixxx_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No local Scoop manifest found; do not add one until stable upstream archive/installer extraction and current-user smoke evidence are captured.; Choco=deferred; ChocoId=mixxx; ChocoStrategy=Chocolatey mixxx package exists, but current visible package is alpha; defer as SOTA install source for hardened no-admin use.; Evidence=System.Object[]; Decision=Deferred after cleanup; package route needs stable release source and isolated no-admin smoke before hardening.; Desc=Track Mixxx packaging feasibility after local cleanup.}.State).
- Runtime validation: $(@{Id=mixxx; Name=Mixxx; Version=; Track=mixxx_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No local Scoop manifest found; do not add one until stable upstream archive/installer extraction and current-user smoke evidence are captured.; Choco=deferred; ChocoId=mixxx; ChocoStrategy=Chocolatey mixxx package exists, but current visible package is alpha; defer as SOTA install source for hardened no-admin use.; Evidence=System.Object[]; Decision=Deferred after cleanup; package route needs stable release source and isolated no-admin smoke before hardening.; Desc=Track Mixxx packaging feasibility after local cleanup.}.Runtime).
- Decision: Deferred after cleanup; package route needs stable release source and isolated no-admin smoke before hardening.

## 2026-06-15 Implementation Closure
- [x] Added official Mixxx 2.5.6 Scoop manifest at `bucket/mixxx.json`.
- [x] Added Chocolatey package source at `packaging/chocolatey/mixxx/`.
- [x] Updated contract to mark Scoop and Chocolatey package-source targets implemented.
- Runtime closure: local Scoop install, binary, shim, and service-side-effect checks passed; Chocolatey package source packs successfully, with isolated Chocolatey install proof retained as a later hardening gate.
