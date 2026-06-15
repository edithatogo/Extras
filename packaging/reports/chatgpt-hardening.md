# ChatGPT Desktop Hardening Evidence

- Contract: `chatgpt`
- Track: `conductor/tracks/chatgpt_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Local Scoop extras/chatgpt points to github.com/lencx/ChatGPT.
- Chocolatey chatgpt page is ChatGPT Desktop (Unofficial).

## No-Admin Strategy
Blocked until a supported current-user, no-UAC, no-HKLM, no-service route exists.

## Hard Blockers
- UAC prompt
- Program Files write
- HKLM write
- service or driver registration
- unofficial or ambiguous source identity

## Target Posture
- Scoop: `blocked` - Do not use local extras/chatgpt for official ChatGPT because it points to lencx/ChatGPT, an unofficial app.
- Chocolatey: `blocked` - Chocolatey chatgpt is marked unofficial; block for official OpenAI desktop packaging until an official user-scoped source is available.

## Decision
Blocked for official ChatGPT packaging because available Scoop/Chocolatey routes are unofficial.
