# Track Spec: TightVNC No-Admin Packaging

## Goal
Bring TightVNC Android-mirroring use from `DroidVNC-NG` path into a controlled, auditable no-admin posture.

## Scope
- Contract: `packaging/contracts/tightvnc.json`
- Scoop manifest: `bucket/tightvnc.json`

## Acceptance Criteria
- Contract target metadata matches manifest existence.
- Blockers (services, optional server install paths) are explicit and decisioned.
- Chocolatey deferral does not block the existing Scoop full-bundle manifest; hardened no-admin Android mirroring still uses `tightvnc-viewer`.

