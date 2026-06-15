# Track Plan: Pencil No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=pencil; Name=Pencil; Version=3.1.1; Track=pencil_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/pencil for Evolus Pencil; manifest extracts NSIS app payload into Scoop directory.; Choco=deferred; ChocoId=pencil; ChocoStrategy=Chocolatey route not accepted until package identity and no-admin behavior are confirmed; Scoop is sufficient.; Evidence=System.Object[]; Decision=Covered by upstream Scoop for Evolus Pencil; Chocolatey remains deferred for identity/no-admin proof.; Desc=Track Pencil package-manager coverage and identity split.}.Status).
- Readiness state: $(@{Id=pencil; Name=Pencil; Version=3.1.1; Track=pencil_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/pencil for Evolus Pencil; manifest extracts NSIS app payload into Scoop directory.; Choco=deferred; ChocoId=pencil; ChocoStrategy=Chocolatey route not accepted until package identity and no-admin behavior are confirmed; Scoop is sufficient.; Evidence=System.Object[]; Decision=Covered by upstream Scoop for Evolus Pencil; Chocolatey remains deferred for identity/no-admin proof.; Desc=Track Pencil package-manager coverage and identity split.}.State).
- Runtime validation: $(@{Id=pencil; Name=Pencil; Version=3.1.1; Track=pencil_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=nsis; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop extras/pencil for Evolus Pencil; manifest extracts NSIS app payload into Scoop directory.; Choco=deferred; ChocoId=pencil; ChocoStrategy=Chocolatey route not accepted until package identity and no-admin behavior are confirmed; Scoop is sufficient.; Evidence=System.Object[]; Decision=Covered by upstream Scoop for Evolus Pencil; Chocolatey remains deferred for identity/no-admin proof.; Desc=Track Pencil package-manager coverage and identity split.}.Runtime).
- Decision: Covered by upstream Scoop for Evolus Pencil; Chocolatey remains deferred for identity/no-admin proof.

## 2026-06-15 Implementation Closure
- [x] Kept Scoop route covered by upstream `pencil`.
- [x] Added Chocolatey package source at `packaging/chocolatey/pencil/`.
- [x] Updated contract to mark Chocolatey package-source target implemented.
- Runtime closure: package-source implementation packs successfully; isolated Chocolatey extraction/launch/uninstall proof is retained as a later hardening gate.
