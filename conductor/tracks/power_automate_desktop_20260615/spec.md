# Track Spec: Power Automate Desktop No-Admin Package-Manager Posture

## Goal
Classify and harden the Scoop/Chocolatey posture for Power Automate Desktop under the repository no-admin packaging contract.

## Scope
- Record whether Scoop and Chocolatey routes already exist.
- Block unofficial, licensed, Store-only, machine-scope, service, driver, HKLM, or Program Files install paths.
- Avoid duplicating upstream package-manager manifests when an acceptable route already exists.
- Keep runtime smoke separate from static package discovery.

## Status
- **Status:** completed
- **Decision:** Blocked for no-admin hardening until isolated evidence proves a user-scope install with no machine side effects.
