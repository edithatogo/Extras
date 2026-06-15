# Chocolatey Submission Readiness

This folder records Chocolatey posture for no-admin package candidates.

The repository does not publish Chocolatey packages automatically. A Chocolatey candidate is submission-ready only when the contract proves a `$toolsDir` or other user-writable layout that avoids UAC, HKLM, Program Files, services, drivers, and machine runtime bootstrapping.

For the current tranche, Chocolatey remains candidate or blocked for most locally implemented Scoop manifests because the Scoop route uses package-manager extraction while Chocolatey packaging still needs a separate `.nuspec` and `tools/chocolateyInstall.ps1` implementation.
