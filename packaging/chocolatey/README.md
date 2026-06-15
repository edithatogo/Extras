# Chocolatey Package Sources

This folder contains package-source definitions for no-admin Chocolatey candidates.

The package contract remains the source of truth. A Chocolatey target can only be marked `implemented` when this folder contains a package directory with a `.nuspec` file and `tools/chocolateyinstall.ps1`. Runtime hardening is a separate gate: package files are not enough to mark the overall candidate SOTA-complete unless isolated install, launch, uninstall, and side-effect checks pass.

Package scripts must avoid UAC, HKLM writes, Program Files writes, service or driver registration, and machine-scope bootstrap actions.
