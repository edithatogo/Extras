# No-Admin Package Factory Design

## Overview
The factory adds a contract-first workflow for package candidates. Contracts define the source, installer shape, no-admin strategy, duplicate lookup terms, and Scoop/Chocolatey target status before implementation starts.

```mermaid
flowchart TD
    A[Installed app or local installer] --> B[Package contract]
    B --> O[Owning conductor track]
    B --> C[Duplicate lookup]
    B --> D[No-admin feasibility]
    B --> E[Source and license review]
    B --> P[Readiness and evidence reports]
    C --> F[Candidate reports]
    D --> F
    E --> F
    P --> F
    F --> G{Ready for implementation?}
    G -- yes --> H[Scoop manifest]
    G -- yes --> I[Chocolatey package candidate]
    G -- no --> J[Blocked or deferred contract]
```

## Data Flow
Contracts live under `packaging/contracts/`. The audit tools read those contracts, scan local Scoop buckets, optionally query package feeds, and write cache/report outputs.

```mermaid
flowchart LR
    C[contracts/*.json] --> V[Test-PackageContracts.ps1]
    C --> L[Find-Existing.ps1]
    C --> E[Build-ContractEvidenceReports.ps1]
    L --> K[package-existence.json]
    L --> R[package-existence.md]
    E --> HR[*-hardening.md]
    E --> SR[*-noadmin-smoke.md]
    C --> I[Find-InstalledCandidates.ps1]
    I --> SI[installed-candidates-review.md]
    C --> Q[New-CandidateReport.ps1]
    Q --> M[candidate-ranking.md]
    V --> CI[GitHub Actions CI]
    R --> CI
    HR --> CI
    SR --> CI
    M --> CI
```

## No-Admin Decision Tree
Package implementation starts only after the installer can be handled without elevation.

```mermaid
flowchart TD
    A[Candidate installer] --> B{Portable archive?}
    B -- yes --> C[Extract to package directory]
    B -- no --> D{Extractable installer payload?}
    D -- yes --> E[Use extraction helper]
    D -- no --> F{Current-user silent install?}
    F -- yes --> G[Install into user-writable path]
    F -- no --> H[Block candidate]
    C --> I[Launch smoke test]
    E --> I
    G --> I
    I --> J{No UAC and no machine writes?}
    J -- yes --> K[Package can proceed]
    J -- no --> H
```

## Readiness Matrix

```mermaid
flowchart TD
    A[Contracts + Contracts cache] --> B[Build-SotaReadinessReport.ps1]
    B --> C[packaging/reports/sota-readiness.md]
    C --> D[SOTA gating and manual-review decisions]
    C --> E[Track-level plan updates]
```

## Bundle Narrowing
When an upstream installer contains both client-only and service/server components, the factory narrows the package to the minimum binary set needed for the requested workflow.

```mermaid
flowchart TD
    A[Bundle installer] --> B{Requested workflow needs server/service?}
    B -- no --> C[Create client-only manifest]
    C --> D[Expose only safe binaries]
    D --> E[Runtime smoke validation]
    B -- yes --> F[Block until service/driver behavior is validated]
    E --> G{No UAC/HKLM/service effects?}
    G -- yes --> H[Candidate can advance]
    G -- no --> F
```

## CI Contract
The CI path is offline-first. It validates contracts and regenerates reports without requiring Chocolatey or WinGet network access. Online lookup should run as a scheduled refresh once cache handling is stable.

```mermaid
sequenceDiagram
    participant PR as Pull Request
    participant CI as GitHub Actions
    participant C as Contracts
    participant T as Audit Tools
    participant R as Reports
    PR->>CI: push or pull_request
    CI->>C: validate JSON contracts
    CI->>T: run offline duplicate lookup
    CI->>T: generate contract evidence reports
    T->>R: write cache and reports
    CI->>CI: run Scoop bucket tests
```

## Submission Readiness

```mermaid
flowchart TD
    A[Contract] --> B{Scoop implemented?}
    B -- yes --> C[Scoop manifest exists]
    C --> D[Scoop submission note]
    B -- no --> E[No Scoop submission required]
    A --> F{Chocolatey candidate or implemented?}
    F -- yes --> G[Chocolatey submission note]
    G --> H{Chocolatey implemented?}
    H -- yes --> K[.nuspec and tools/chocolateyinstall.ps1]
    H -- no --> L[Feasibility note only]
    F -- no --> M[No Chocolatey submission required]
    D --> I[Test-SubmissionReadiness.ps1]
    K --> I
    L --> I
    I --> J[GitHub Actions gate]
```

## Chocolatey No-Admin Flow

```mermaid
flowchart TD
    A[Candidate has contract] --> B{Scoop target implemented?}
    B -- yes --> C{Can install into $toolsDir?}
    B -- no --> D[Track as Scoop-only for now]
    C -- no --> E[Chocolatey blocked: machine install required]
    C -- yes --> F{Installer writes Program Files/HKLM?}
    F -- yes --> G[Need extraction-first path or user-writable transform]
    F -- no --> H[Portable/package-tools layout feasible]
    G --> I{Do we have reproducible upstream artifact?}
    I -- yes --> J[Add choco feasibility guidance in contract]
    I -- no --> K[Block from no-admin Chocolatey readiness]
```

## Guardrails
- Contract validation is required before implementation.
- Duplicate lookup is required before implementation.
- Online lookup failures are warnings unless the candidate is being marked ready.
- Any elevation, machine-wide install, service, driver, HKLM write, or Program Files write blocks no-admin readiness.
- WebView2-dependent apps must use an existing user/fixed runtime strategy rather than machine bootstrapping.
- Implemented Chocolatey targets require concrete package-source files and static no-admin script checks; a Markdown submission note alone is not sufficient.
