# Track Plan: Antigravity No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=antigravity; Name=Antigravity; Version=2.1.4; Track=antigravity_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/antigravity, extras/antigravity-ide, or main/antigravity-cli as appropriate; avoid duplicate local manifests.; Choco=covered; ChocoId=antigravity; ChocoStrategy=Chocolatey antigravity package exists; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream package routes; local machine has one registered Antigravity install.; Desc=Track Antigravity package-manager coverage and one-version local posture.}.Status).
- Readiness state: $(@{Id=antigravity; Name=Antigravity; Version=2.1.4; Track=antigravity_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/antigravity, extras/antigravity-ide, or main/antigravity-cli as appropriate; avoid duplicate local manifests.; Choco=covered; ChocoId=antigravity; ChocoStrategy=Chocolatey antigravity package exists; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream package routes; local machine has one registered Antigravity install.; Desc=Track Antigravity package-manager coverage and one-version local posture.}.State).
- Runtime validation: $(@{Id=antigravity; Name=Antigravity; Version=2.1.4; Track=antigravity_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/antigravity, extras/antigravity-ide, or main/antigravity-cli as appropriate; avoid duplicate local manifests.; Choco=covered; ChocoId=antigravity; ChocoStrategy=Chocolatey antigravity package exists; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream package routes; local machine has one registered Antigravity install.; Desc=Track Antigravity package-manager coverage and one-version local posture.}.Runtime).
- Decision: Covered by upstream package routes; local machine has one registered Antigravity install.

## 2026-06-15 Implementation Closure
- [x] Kept Scoop route covered by upstream `antigravity`.
- [x] Added Chocolatey package source at `packaging/chocolatey/antigravity/`.
- [x] Updated contract to mark Chocolatey package-source target implemented.
- Runtime closure: package-source implementation packs successfully against the official 2.1.4 artifact; isolated extraction/launch/uninstall proof is retained as a later hardening gate.
