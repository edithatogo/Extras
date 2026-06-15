# Track Plan: ChatGPT Desktop No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=chatgpt; Name=ChatGPT Desktop; Version=; Track=chatgpt_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=Do not use local extras/chatgpt for official ChatGPT because it points to lencx/ChatGPT, an unofficial app.; Choco=blocked; ChocoId=chatgpt; ChocoStrategy=Chocolatey chatgpt is marked unofficial; block for official OpenAI desktop packaging until an official user-scoped source is available.; Evidence=System.Object[]; Decision=Blocked for official ChatGPT packaging because available Scoop/Chocolatey routes are unofficial.; Desc=Track official ChatGPT desktop package-manager posture.}.Status).
- Readiness state: $(@{Id=chatgpt; Name=ChatGPT Desktop; Version=; Track=chatgpt_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=Do not use local extras/chatgpt for official ChatGPT because it points to lencx/ChatGPT, an unofficial app.; Choco=blocked; ChocoId=chatgpt; ChocoStrategy=Chocolatey chatgpt is marked unofficial; block for official OpenAI desktop packaging until an official user-scoped source is available.; Evidence=System.Object[]; Decision=Blocked for official ChatGPT packaging because available Scoop/Chocolatey routes are unofficial.; Desc=Track official ChatGPT desktop package-manager posture.}.State).
- Runtime validation: $(@{Id=chatgpt; Name=ChatGPT Desktop; Version=; Track=chatgpt_20260615; Status=blocked; State=blocked; Runtime=blocked; Priority=requested; Installer=unknown; Scoop=blocked; ScoopManifest=; ScoopStrategy=Do not use local extras/chatgpt for official ChatGPT because it points to lencx/ChatGPT, an unofficial app.; Choco=blocked; ChocoId=chatgpt; ChocoStrategy=Chocolatey chatgpt is marked unofficial; block for official OpenAI desktop packaging until an official user-scoped source is available.; Evidence=System.Object[]; Decision=Blocked for official ChatGPT packaging because available Scoop/Chocolatey routes are unofficial.; Desc=Track official ChatGPT desktop package-manager posture.}.Runtime).
- Decision: Blocked for official ChatGPT packaging because available Scoop/Chocolatey routes are unofficial.
