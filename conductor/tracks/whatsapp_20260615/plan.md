# Track Plan: WhatsApp Official App No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=whatsapp; Name=WhatsApp Official App; Version=; Track=whatsapp_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop manifest for official WhatsApp Desktop; avoid unofficial wrappers.; Choco=blocked; ChocoId=whatsapp; ChocoStrategy=No confirmed official Chocolatey route; official app is Store/WinGet oriented and outside this no-admin Scoop/Chocolatey contract.; Evidence=System.Object[]; Decision=Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.; Desc=Track official WhatsApp desktop package-manager posture.}.Status).
- Readiness state: $(@{Id=whatsapp; Name=WhatsApp Official App; Version=; Track=whatsapp_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop manifest for official WhatsApp Desktop; avoid unofficial wrappers.; Choco=blocked; ChocoId=whatsapp; ChocoStrategy=No confirmed official Chocolatey route; official app is Store/WinGet oriented and outside this no-admin Scoop/Chocolatey contract.; Evidence=System.Object[]; Decision=Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.; Desc=Track official WhatsApp desktop package-manager posture.}.State).
- Runtime validation: $(@{Id=whatsapp; Name=WhatsApp Official App; Version=; Track=whatsapp_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=No local Scoop manifest for official WhatsApp Desktop; avoid unofficial wrappers.; Choco=blocked; ChocoId=whatsapp; ChocoStrategy=No confirmed official Chocolatey route; official app is Store/WinGet oriented and outside this no-admin Scoop/Chocolatey contract.; Evidence=System.Object[]; Decision=Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.; Desc=Track official WhatsApp desktop package-manager posture.}.Runtime).
- Decision: Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.
