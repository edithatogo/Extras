# Track Plan: Power BI Desktop No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=power-bi-desktop; Name=Power BI Desktop; Version=; Track=power_bi_desktop_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop bucket route found; block no-admin packaging because supported installers are machine/Store/enterprise oriented.; Choco=blocked; ChocoId=powerbi; ChocoStrategy=No confirmed no-admin Chocolatey route; block until user-scoped installer evidence exists.; Evidence=System.Object[]; Decision=Blocked for no-admin Scoop/Chocolatey packaging pending a supported user-scoped installer.; Desc=Track Power BI Desktop no-admin package-manager posture.}.Status).
- Readiness state: $(@{Id=power-bi-desktop; Name=Power BI Desktop; Version=; Track=power_bi_desktop_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop bucket route found; block no-admin packaging because supported installers are machine/Store/enterprise oriented.; Choco=blocked; ChocoId=powerbi; ChocoStrategy=No confirmed no-admin Chocolatey route; block until user-scoped installer evidence exists.; Evidence=System.Object[]; Decision=Blocked for no-admin Scoop/Chocolatey packaging pending a supported user-scoped installer.; Desc=Track Power BI Desktop no-admin package-manager posture.}.State).
- Runtime validation: $(@{Id=power-bi-desktop; Name=Power BI Desktop; Version=; Track=power_bi_desktop_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=msi; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop bucket route found; block no-admin packaging because supported installers are machine/Store/enterprise oriented.; Choco=blocked; ChocoId=powerbi; ChocoStrategy=No confirmed no-admin Chocolatey route; block until user-scoped installer evidence exists.; Evidence=System.Object[]; Decision=Blocked for no-admin Scoop/Chocolatey packaging pending a supported user-scoped installer.; Desc=Track Power BI Desktop no-admin package-manager posture.}.Runtime).
- Decision: Blocked for no-admin Scoop/Chocolatey packaging pending a supported user-scoped installer.
