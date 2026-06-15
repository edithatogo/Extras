# Track Plan: Anaconda No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=anaconda; Name=Anaconda; Version=2025.12-2; Track=anaconda_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=unknown; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/anaconda3; it passes JustMe, NoRegistry, and user-writable destination arguments.; Choco=covered; ChocoId=anaconda3; ChocoStrategy=Chocolatey anaconda3 package exists; prefer Scoop route for strict no-admin unless Chocolatey self-service is configured.; Evidence=System.Object[]; Decision=Covered by upstream package routes; no fork-local manifest required.; Desc=Track Anaconda package-manager coverage.}.Status).
- Readiness state: $(@{Id=anaconda; Name=Anaconda; Version=2025.12-2; Track=anaconda_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=unknown; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/anaconda3; it passes JustMe, NoRegistry, and user-writable destination arguments.; Choco=covered; ChocoId=anaconda3; ChocoStrategy=Chocolatey anaconda3 package exists; prefer Scoop route for strict no-admin unless Chocolatey self-service is configured.; Evidence=System.Object[]; Decision=Covered by upstream package routes; no fork-local manifest required.; Desc=Track Anaconda package-manager coverage.}.State).
- Runtime validation: $(@{Id=anaconda; Name=Anaconda; Version=2025.12-2; Track=anaconda_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=unknown; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/anaconda3; it passes JustMe, NoRegistry, and user-writable destination arguments.; Choco=covered; ChocoId=anaconda3; ChocoStrategy=Chocolatey anaconda3 package exists; prefer Scoop route for strict no-admin unless Chocolatey self-service is configured.; Evidence=System.Object[]; Decision=Covered by upstream package routes; no fork-local manifest required.; Desc=Track Anaconda package-manager coverage.}.Runtime).
- Decision: Covered by upstream package routes; no fork-local manifest required.

## 2026-06-15 Implementation Closure
- [x] Kept Scoop route covered by upstream `anaconda3`.
- [x] Added Chocolatey package source at `packaging/chocolatey/anaconda3/`.
- [x] Updated contract to mark Chocolatey package-source target implemented.
- Runtime closure: package-source implementation packs successfully; heavyweight isolated Anaconda install/command/uninstall proof is retained as a later hardening gate.
