# Track Plan: Check No-Admin Packaging SOTA

This track defines how SOTA is validated before any candidate is treated as hardened.

---

## Phase 1: Baseline Governance

- [x] Task: Confirm `packaging/requirements.md` keeps MoSCoW gates and that every "Must" requirement has a concrete owner file.
- [x] Task: Confirm `packaging/design.md` includes Mermaid workflows for no-admin decision flow, factory flow, and CI flow.
- [x] Task: Confirm package schema and validators exist under `packaging/contract.schema.json`, `tools/package-audit/Test-PackageContracts.ps1`, `tools/package-audit/Test-CiContracts.ps1`, and `bin/Package-Factory.Tests.ps1`.
- [x] Task: Confirm contracts exist for all tracked candidates in `packaging/contracts/`.
- [x] Task: Maintain a contract-to-track map in this track and block candidates without a matching plan folder in `conductor/tracks/*`.
- [x] Task: Confirm each map entry indicates whether candidate status is `implemented`, `candidate`, `blocked`, `covered`, or `deferred`.
- [x] Task: Run contract validators in the same order as CI and record outputs in `packaging/reports/contract-validation.md`.

## Contract-to-Track Map

| Contract | Track | Contract Status | Scoop Target | Chocolatey Target | Notes |
| --- | --- | --- | --- | --- | --- |
| pinokio | [pinokio_20260613](../pinokio_20260613/) | candidate | implemented | candidate | manifest-first NSIS payload extraction lane; local install validation passed |
| omnivoice-studio | [omnivoice_studio_20260613](../omnivoice_studio_20260613/) | candidate | implemented | candidate | native MSI extraction only; local install validation passed |
| voicebox | [voicebox_20260613](../voicebox_20260613/) | candidate | implemented | candidate | native MSI extraction with WebView2 externalized; local install validation passed |
| nomachine-enterprise-client | [nomachine_20260604](../nomachine_20260604/) | candidate | implemented | candidate | local install validation passed; HKCU uninstall caveat recorded |
| android-studio | [android_studio_20260613](../android_studio_20260613/) | covered | implemented | candidate | article method via Android Studio mirroring |
| droidvnc-ng | [droidvnc_ng_20260613](../droidvnc_ng_20260613/) | blocked | blocked | blocked | mobile-only APK route |
| microsoft-phone-link | [microsoft_phone_link_20260613](../microsoft_phone_link_20260613/) | blocked | blocked | blocked | Store/UWP constraints |
| scrcpy | [scrcpy_20260613](../scrcpy_20260613/) | covered | covered | candidate | covered by local Scoop `main` bucket ZIP manifest plus `adb` dependency |
| scrcpy-plus | [scrcpy_plus_20260613](../scrcpy_plus_20260613/) | candidate | blocked | candidate | GUI wrapper route deferred |
| tightvnc | [tightvnc_20260613](../tightvnc_20260613/) | deferred | deferred | deferred | full bundle exposes server/service surface |
| tightvnc-viewer | [tightvnc_viewer_20260614](../tightvnc_viewer_20260614/) | candidate | implemented | candidate | viewer-only MSI extraction path; local install validation passed |
| installed-candidates | [installed_candidates_20260614](../installed_candidates_20260614/) | candidate | candidate | candidate | aggregate lane for installed-app audit candidates before dedicated promotion |
| mixxx | [mixxx_20260615](../mixxx_20260615/) | deferred | deferred | deferred | local program folders removed; package route needs stable release proof |
| pencil | [pencil_20260615](../pencil_20260615/) | covered | covered | deferred | upstream Scoop coverage; Chocolatey identity/no-admin deferred |
| anaconda | [anaconda_20260615](../anaconda_20260615/) | covered | covered | covered | upstream Scoop/Chocolatey coverage; prefer Scoop JustMe route |
| endnote | [endnote_20260615](../endnote_20260615/) | blocked | blocked | blocked | licensed machine-scope install posture |
| whatsapp | [whatsapp_20260615](../whatsapp_20260615/) | blocked | blocked | blocked | official app is Store/WinGet oriented, not Scoop/Chocolatey no-admin |
| power-automate-process-mining | [power_automate_process_mining_20260615](../power_automate_process_mining_20260615/) | blocked | blocked | blocked | no separate desktop package route found |
| power-automate-desktop | [power_automate_desktop_20260615](../power_automate_desktop_20260615/) | blocked | blocked | blocked | Chocolatey exists but machine-scope risk blocks no-admin hardening |
| power-bi-desktop | [power_bi_desktop_20260615](../power_bi_desktop_20260615/) | blocked | blocked | blocked | no confirmed no-admin Scoop/Chocolatey route |
| github-copilot-desktop | [github_copilot_desktop_20260615](../github_copilot_desktop_20260615/) | deferred | deferred | deferred | installed current-user app but no confirmed stable package-manager source |
| antigravity | [antigravity_20260615](../antigravity_20260615/) | covered | covered | covered | upstream Scoop/Chocolatey route; one local current-user install verified |
| chatgpt | [chatgpt_20260615](../chatgpt_20260615/) | blocked | blocked | blocked | available package-manager routes are unofficial, not official OpenAI desktop app |
| codex | [codex_20260615](../codex_20260615/) | covered | covered | covered | upstream Scoop/Chocolatey coverage; no local duplicate |

## Phase 2: Hardening Gates

- [x] Task: Define and use one hardening gate for each candidate:
  - installation without UAC prompt
  - no HKLM and no Program Files writes
  - no service/driver registration
  - stable reproducible source metadata (hash/version/checkver/autoupdate)
- [x] Task: Produce per-candidate hardening check evidence:
  - `packaging/reports/<candidate>-hardening.md`
  - command outputs or explicit "Not yet runnable" notes.
- [x] Task: Make duplicate lookup outputs deterministic and auditable by running `Find-Existing.ps1` against cached and live sources where possible.
- [x] Task: Require that each hardening gate has a "pass / blocked / deferred" status before manifest or guidance work is finalised.

Readiness implementation note:
- `packaging/reports/sota-readiness.md` is now the single source for current SOTA status and records each contract as `blocked`, `deferred`, or `candidate-requires-runtime-validation`.

## Phase 3: Integration with Installed-App Signals

- [x] Task: Use `packaging/reports/installed-candidates-review.md` (supersedes scoop-only report) to justify any non-requested candidate inclusion.
- [x] Task: For each shortlist entry, record: contract id, collision check results, blocker class, and implementation decision.
- [x] Task: Update this track and the individual specs when a candidate moves from requested to implemented, becomes blocked, or changes blocker profile.

## Phase 4: Exit and Manual Verification

- [x] Task: Manual verification gate recorded as deferred/not-run for isolated runtime execution; do not claim runtime-ready status without a later smoke pass.
- [x] Task: Add a final statement in this track that all active candidates are either implemented, covered, deferred, blocked, or candidate-requires-runtime-validation with reasons.
- [x] Task: Mark this track complete because every active candidate has an auditable terminal state: implemented, covered, blocked, deferred, or candidate-requires-runtime-validation.

Execution status:
- Close package-building candidates now have user-scope Scoop install/link/binary-presence validation recorded; GUI launch and uninstall cleanup remain separate evidence boundaries unless explicitly run.
- Covered routes are treated as upstream package-manager coverage, not local duplicate manifests.

Final status (2026-06-15):
- Pinokio: active candidate, manifest-first and no UAC claim only when pre-install extraction checks pass (`bucket/pinokio.json`).
- OmniVoice Studio: active candidate, extraction-only manifest; WebView2 dependency documented in `bucket/omnivoice-studio.json`.
- Voicebox: active candidate, extraction-only manifest; optional server/client entries captured in manifest and runtime validation still blocked.
- NoMachine Enterprise Client: implemented for Scoop route, blocked/deferred for Chocolatey machine-scope dependency.
- Microsoft Phone Link: blocked due Store/UWP path and dependency on Microsoft account pairing entitlement.
- DroidVNC-NG: blocked due mobile-server + desktop-client dependency split and no native Scoop route.
- TightVNC Viewer: implemented as a viewer-only Scoop candidate for the DroidVNC-NG desktop client path; runtime smoke remains pending.
- Codex, Antigravity, Anaconda, and Pencil: covered by upstream package-manager routes and not duplicated locally.
- ChatGPT official, Power BI Desktop, Power Automate Desktop, Power Automate Process Mining, WhatsApp official, and EndNote: blocked for strict no-admin Scoop/Chocolatey packaging until official user-scoped routes exist.
- GitHub Copilot Desktop and Mixxx: deferred candidates pending stable public source metadata and isolated no-admin smoke proof.

