# Track Spec: Codex No-Admin Package-Manager Posture

## Goal
Classify and harden the Scoop/Chocolatey posture for Codex under the repository no-admin packaging contract.

## Scope
- Record whether Scoop and Chocolatey routes already exist.
- Block unofficial, licensed, Store-only, machine-scope, service, driver, HKLM, or Program Files install paths.
- Avoid duplicating upstream package-manager manifests when an acceptable route already exists.
- Keep runtime smoke separate from static package discovery.

## Status
- **Status:** completed
- **Decision:** Covered by upstream Scoop and Chocolatey routes; do not duplicate in this fork.
