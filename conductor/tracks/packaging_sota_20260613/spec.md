# Track Spec: Check No-Admin Packaging SOTA

## Goal
Establish and enforce a single source of truth for mature, hardened no-admin readiness across Scoop and Chocolatey feasibility.

## Scope
- Scoop manifests are the implementation target in this repository.
- Chocolatey is tracked as feasibility guidance unless a separate Chocolatey repo/workspace is introduced.
- No package is considered ready until hardening gates in this track are passed.

## Acceptance Criteria
- Contracts are valid under `packaging/contract.schema.json`.
- Duplicate lookup is run and results are available in `packaging/reports`.
- No-manifest track is treated as blocked when a candidate cannot satisfy UAC, HKLM, Program Files, service, or driver constraints.
- Any candidate claiming no-admin ready in this repo must have explicit evidence and an install/launch route that does not execute a machine-scope installer path.

## Hardening Gates
1. **Governance Gate**
   - MoSCoW rules, Mermaid design, schema, and tooling are present and consistent.
2. **Evidence Gate**
   - Contract validation output and duplicate lookup outputs are saved under `packaging/reports`.
3. **Security Gate**
   - Installer and runtime checks for each candidate avoid UAC, HKLM, Program Files, services, drivers, and machine-scoped bootstrap actions.
4. **Feasibility Gate**
   - Scoop manifest/metadata strategy and Chocolatey route are documented and aligned with contract `targets`.
5. **Verification Gate**
   - Manual verification task is executed per workflow protocol and attached to this track.

## Operational Notes
- Current tracks under SOTA: NoMachine, Pinokio, OmniVoice Studio, Voicebox.
- Contracts with implemented tracks should be moved to status `implemented` only after both hardening and manual verification evidence exists.
- Candidates should move to `ready`/`blocked` based on evidence, not on assumptions from local files.
