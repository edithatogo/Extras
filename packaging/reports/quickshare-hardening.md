# Quick Share Hardening Evidence

- Contract: `quickshare`
- Track: `conductor/tracks/quickshare_20260615/`
- Last reviewed: 2026-06-15
- Readiness state: `blocked`
- Runtime validation: `blocked`

## Source Evidence
- no explicit source entries; see installer evidence and duplicate lookup terms

## Installer Evidence
- Current Scoop manifest source is Google better_together.msi from dl.google.com.
- Manifest installs to %ProgramFiles%\Google\Quick Share.
- Installer path is machine-scope and not a proven extraction-only no-admin route.
- PR #3 review comments required explicit msiexec/admin lifecycle handling and autoupdate token fixes; that installer route is rejected for this no-admin factory.

## No-Admin Strategy
Block no-admin factory submission unless a pure extraction route is proven that avoids MSI execution, Program Files writes, HKLM writes, services, drivers, and common Start Menu writes.

## Hard Blockers
- machine-scope MSI execution
- Program Files write
- HKLM write
- Common Start Menu write
- service or driver registration

## Target Posture
- Scoop: `blocked` - No Scoop manifest is included for this no-admin factory route; the reviewed MSI route requires machine-scope msiexec/admin handling and remains blocked until extraction-only install is proven.
- Chocolatey: `blocked` - Do not create a Chocolatey package that executes the machine-scope MSI. Only a tools-dir extraction package is acceptable.

## Decision
Quick Share is tracked as requested, but the available Google MSI is machine-scope and not suitable for the no-admin package factory. PR #3 comments were addressed by rejecting the MSI installer manifest rather than adding admin install/uninstall behavior.
