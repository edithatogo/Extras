# Track Plan: Codex No-Admin Package-Manager Posture

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
- Contract status: $(@{Id=codex; Name=Codex; Version=0.139.0; Track=codex_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=portable; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop main/codex; direct GitHub release exe shims are user-writable and no local fork manifest is needed.; Choco=covered; ChocoId=codex; ChocoStrategy=Chocolatey package exists for Codex CLI; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream Scoop and Chocolatey routes; do not duplicate in this fork.; Desc=Track Codex package-manager coverage and no-admin posture.}.Status).
- Readiness state: $(@{Id=codex; Name=Codex; Version=0.139.0; Track=codex_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=portable; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop main/codex; direct GitHub release exe shims are user-writable and no local fork manifest is needed.; Choco=covered; ChocoId=codex; ChocoStrategy=Chocolatey package exists for Codex CLI; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream Scoop and Chocolatey routes; do not duplicate in this fork.; Desc=Track Codex package-manager coverage and no-admin posture.}.State).
- Runtime validation: $(@{Id=codex; Name=Codex; Version=0.139.0; Track=codex_20260615; Status=covered; State=covered; Runtime=not-required; Priority=requested; Installer=portable; Scoop=covered; ScoopManifest=; ScoopStrategy=Use upstream Scoop main/codex; direct GitHub release exe shims are user-writable and no local fork manifest is needed.; Choco=covered; ChocoId=codex; ChocoStrategy=Chocolatey package exists for Codex CLI; no local package files in this Scoop fork.; Evidence=System.Object[]; Decision=Covered by upstream Scoop and Chocolatey routes; do not duplicate in this fork.; Desc=Track Codex package-manager coverage and no-admin posture.}.Runtime).
- Decision: Covered by upstream Scoop and Chocolatey routes; do not duplicate in this fork.

## 2026-06-15 Implementation Closure
- [x] Kept Scoop route covered by upstream `codex`.
- [x] Added Chocolatey package source at `packaging/chocolatey/codex/`.
- [x] Updated contract to mark Chocolatey package-source target implemented.
- Runtime closure: package-source implementation packs successfully; isolated `codex --version` and uninstall proof is retained as a later hardening gate.
