# Track Spec: WhatsApp Official App No-Admin Package-Manager Posture

## Goal
Classify and harden the Scoop/Chocolatey posture for WhatsApp Official App under the repository no-admin packaging contract.

## Scope
- Record whether Scoop and Chocolatey routes already exist.
- Block unofficial, licensed, Store-only, machine-scope, service, driver, HKLM, or Program Files install paths.
- Avoid duplicating upstream package-manager manifests when an acceptable route already exists.
- Keep runtime smoke separate from static package discovery.

## Status
- **Status:** completed
- **Decision:** Blocked for official no-admin Scoop/Chocolatey packaging; prefer Store/WinGet governance outside this bucket.
