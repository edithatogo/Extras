# No-Admin Submission Workflow

```mermaid
flowchart TD
    A[Package contract] --> B{Scoop target implemented?}
    B -- yes --> C[Local scoop install manifest]
    C --> D[Verify shims and primary binaries]
    D --> E[Check no HKLM service side effects]
    E --> F[Scoop submission checklist]
    B -- no --> G[Blocked, covered, or deferred]
    A --> H{Chocolatey target candidate?}
    H -- yes --> I[Record toolsDir strategy]
    I --> J[Block if installer needs machine scope]
    J --> K{Implemented?}
    K -- yes --> N[Add .nuspec and tools/chocolateyinstall.ps1]
    N --> P[Test-NoAdminPackageSources.ps1]
    P --> Q[Test-ChocolateyPackages.ps1]
    K -- no --> O[Chocolatey submission note only]
    H -- no --> L[No Chocolatey submission]
    F --> M[Test-SubmissionReadiness.ps1]
    Q --> M
    O --> M
```

## Exit Criteria

- `tools/package-audit/Test-PackageContracts.ps1`
- `tools/package-audit/Test-SubmissionReadiness.ps1`
- `tools/package-audit/Test-NoAdminPackageSources.ps1`
- `tools/package-audit/Test-ChocolateyPackages.ps1`
- `tools/package-audit/Test-CiContracts.ps1`
- `bin/Package-Factory.Tests.ps1`
- `git diff --check`

Implemented Chocolatey targets additionally require `packaging/chocolatey/<package_id>/<package_id>.nuspec` and `packaging/chocolatey/<package_id>/tools/chocolateyinstall.ps1`. Static CI blocks admin helpers, machine-scope package installers, Program Files, HKLM, service, and driver patterns.

## Evidence Boundaries

Install/link/binary-presence validation is enough to call a Scoop manifest implemented when the manifest is extraction-first or installs into the user Scoop app directory. GUI launch and uninstall cleanup require explicit separate evidence before they can be described as passed.
