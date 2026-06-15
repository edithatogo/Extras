# Product Guidelines - Scoop Extras Bucket

This document defines the guidelines and standards for contributions, updates, and maintenance of manifests in the Scoop Extras bucket.

## 1. Manifest Structure & Schema Standards
- **Schema Validation:** All manifests must conform to the official Scoop manifest schema.
- **Key Properties:** Standard properties like `version`, `description`, `homepage`, `license`, `url`, and `hash` must be present.
- **Architecture Keys:** Differentiate download URLs and hashes for `32bit`, `64bit`, and `arm64` where applicable.
- **Indentation:** Format JSON files with 4 spaces indentation.
- **Key Ordering:** Maintain a consistent order of top-level keys for readability (e.g., version, description, homepage, license, etc.).

## 2. Automated Version Updates & Excavator
- **Autoupdate Configuration:** Manifests should include an `autoupdate` property outlining how the Excavator tool can automatically parse upstream release versions, download URLs, and recalculate hashes.
- **Automation Preference:** Automating updates using the `autoupdate` key is highly preferred over manual version bumps.

## 3. Directory Layout & Lifecycle
- **Flat Bucket:** All active manifests are stored in the flat `bucket/` folder.
- **Manifest Naming:** Filenames must be lowercase and match the identifier of the package.
- **Deprecated Packages:** Outdated, unmaintained, or broken software manifests should be moved to the `deprecated/` directory to preserve history while warning users.

## 4. Validation & Testing
- **CI Workflows:** All pull requests run automated tests via GitHub Actions.
- **Pester Tests:** Automated test suites check JSON syntax, validate schema conformance, check link availability, and ensure manifest installability.
