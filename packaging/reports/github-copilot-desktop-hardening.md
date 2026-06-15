# GitHub Copilot Desktop Hardening Evidence

- Contract: `github-copilot-desktop`
- Track: `conductor/tracks/github_copilot_desktop_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `deferred`
- Runtime validation: `deferred`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local registry shows GitHub Copilot 0.2.30 current-user install under AppData\\Local\\Programs\\GitHub Copilot.
- Local Scoop buckets only showed unrelated aws-copilot and copilot-cli.

## No-Admin Strategy
Deferred candidate; require stable public source, extraction strategy, and isolated no-admin runtime smoke before implementation.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `deferred` - No confirmed Scoop manifest for GitHub Copilot Desktop; defer until official stable source URL and extraction strategy are known.
- Chocolatey: `deferred` - No confirmed Chocolatey package route for GitHub Copilot Desktop; portable package only if official source can be resolved.

## Decision
Deferred until an official stable source and user-writable no-admin install strategy are available.
