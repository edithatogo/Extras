# Track Plan: EndNote No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=endnote; Name=EndNote; Version=2025; Track=endnote_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop route found; commercial/licensed installer is machine-scope in current local install.; Choco=blocked; ChocoId=endnote; ChocoStrategy=No confirmed public Chocolatey package route; do not package licensed installer without entitlement and no-admin evidence.; Evidence=System.Object[]; Decision=Blocked for no-admin package-manager treatment due licensing and machine-scope installer posture.; Desc=Track EndNote no-admin package-manager posture.}.Status).
- Readiness state: $(@{Id=endnote; Name=EndNote; Version=2025; Track=endnote_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop route found; commercial/licensed installer is machine-scope in current local install.; Choco=blocked; ChocoId=endnote; ChocoStrategy=No confirmed public Chocolatey package route; do not package licensed installer without entitlement and no-admin evidence.; Evidence=System.Object[]; Decision=Blocked for no-admin package-manager treatment due licensing and machine-scope installer posture.; Desc=Track EndNote no-admin package-manager posture.}.State).
- Runtime validation: $(@{Id=endnote; Name=EndNote; Version=2025; Track=endnote_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop route found; commercial/licensed installer is machine-scope in current local install.; Choco=blocked; ChocoId=endnote; ChocoStrategy=No confirmed public Chocolatey package route; do not package licensed installer without entitlement and no-admin evidence.; Evidence=System.Object[]; Decision=Blocked for no-admin package-manager treatment due licensing and machine-scope installer posture.; Desc=Track EndNote no-admin package-manager posture.}.Runtime).
- Decision: Blocked for no-admin package-manager treatment due licensing and machine-scope installer posture.
