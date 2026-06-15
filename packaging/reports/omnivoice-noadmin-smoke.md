# OmniVoice Studio No-Admin Smoke Evidence

- [ ] Install without UAC in isolated user context (not executed in this run)
- [ ] Launch succeeds via shortcut `OmniVoice Studio` (not executed in this run)
- [ ] WebView2 runtime path is Scoop-owned/fixed (not executed in this run)
- [ ] Uninstall cleans only Scoop/user scope artifacts (not executed in this run)
- [ ] No HKLM/service/driver side effects (not executed in this run)
- [ ] Evidence artifacts captured:
  - install command
  - launch log
  - uninstall verification output

## Run Decision

- Status: evidence-gate pending (`Install/Launch/Uninstall` not executed in this environment).
- Static readiness: manifest avoids `msiexec` and records `extras/webview2` dependency.
