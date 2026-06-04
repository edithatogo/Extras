# Technology Stack - Scoop Extras Bucket

This document lists the technologies, tools, and configurations used in the Scoop Extras bucket.

## Core Formats & Scripts
- **Scoop Manifest Format:** JSON (JavaScript Object Notation) conforming to the Scoop App Schema.
- **Testing & Tooling:** PowerShell (`.ps1` files) for local test execution and manifest verification.
- **Test Framework:** Pester (PowerShell test runner) to evaluate schema validation rules in `Scoop-Bucket.Tests.ps1`.

## Platform & Environments
- **Target OS:** Microsoft Windows (x86, x64, ARM64).
- **Execution Environment:** Windows PowerShell or PowerShell Core.

## Automation & CI/CD
- **Continuous Integration:** GitHub Actions pipelines (defined in `.github/workflows/`) for automated pull request checks.
- **Auto-Updates:** Excavator daemon for scanning new software versions and automatically committing manifest updates.
