# Track Spec: Audit and Validate Bucket Manifests

## Goal
Establish a repeatable audit tool or script that scans active Scoop manifests to verify schema conformance, find broken links/URLs, detect outdated packages, and ensure hashes are correct.

## Scope
- Design and implement a PowerShell-based validation tool that can run locally and in GitHub Actions.
- Ensure all manifests in the `bucket/` folder pass local tests.
- Support options to selectively scan recently changed manifests for PR speed.

## Status
- **Status:** completed
