# Track Plan: GitHub Copilot Desktop No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=github-copilot-desktop; Name=GitHub Copilot Desktop; Version=0.2.30; Track=github_copilot_desktop_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No confirmed Scoop manifest for GitHub Copilot Desktop; defer until official stable source URL and extraction strategy are known.; Choco=deferred; ChocoId=github-copilot-desktop; ChocoStrategy=No confirmed Chocolatey package route for GitHub Copilot Desktop; portable package only if official source can be resolved.; Evidence=System.Object[]; Decision=Deferred until an official stable source and user-writable no-admin install strategy are available.; Desc=Track GitHub Copilot Desktop packaging feasibility.}.Status).
- Readiness state: $(@{Id=github-copilot-desktop; Name=GitHub Copilot Desktop; Version=0.2.30; Track=github_copilot_desktop_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No confirmed Scoop manifest for GitHub Copilot Desktop; defer until official stable source URL and extraction strategy are known.; Choco=deferred; ChocoId=github-copilot-desktop; ChocoStrategy=No confirmed Chocolatey package route for GitHub Copilot Desktop; portable package only if official source can be resolved.; Evidence=System.Object[]; Decision=Deferred until an official stable source and user-writable no-admin install strategy are available.; Desc=Track GitHub Copilot Desktop packaging feasibility.}.State).
- Runtime validation: $(@{Id=github-copilot-desktop; Name=GitHub Copilot Desktop; Version=0.2.30; Track=github_copilot_desktop_20260615; Status=deferred; State=deferred; Runtime=deferred; Priority=requested; Installer=unknown; Scoop=deferred; ScoopManifest=; ScoopStrategy=No confirmed Scoop manifest for GitHub Copilot Desktop; defer until official stable source URL and extraction strategy are known.; Choco=deferred; ChocoId=github-copilot-desktop; ChocoStrategy=No confirmed Chocolatey package route for GitHub Copilot Desktop; portable package only if official source can be resolved.; Evidence=System.Object[]; Decision=Deferred until an official stable source and user-writable no-admin install strategy are available.; Desc=Track GitHub Copilot Desktop packaging feasibility.}.Runtime).
- Decision: Deferred until an official stable source and user-writable no-admin install strategy are available.
