# Track Spec: Quick Share No-Admin Package-Manager Posture

## Goal
Classify Quick Share for Scoop and Chocolatey under the no-admin package factory contract.

## Scope
- Record existing Google Quick Share MSI route.
- Keep the machine-scope upstream installer distinct from no-admin package-factory readiness.
- Block any no-admin submission that executes MSI custom actions, writes Program Files or HKLM, or creates machine-scope services, drivers, or common shortcuts.

## Status
- **Status:** blocked
- **Decision:** Quick Share is requested and tracked, but no-admin packaging is blocked until a pure extraction route is proven.
