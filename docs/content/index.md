---
homepage: true
layout: page
title: Technical documentation
includeInBreadcrumbs: true
eleventyNavigation:
  key: Home
---

Welcome to the Department for Education (DfE) Checkov Policies technical documentation site.

This repository aims to serves as the central hub for custom Checkov policy definitions, compliance test cases, and CI/CD pipelines designed to scan and secure Azure Infrastructure-as-Code (IaC) across DfE landing zones.

## Goal of the project

The core goal of this project is to shift left security compliance and enhance the developer lifecycle and workflow.

### What does "Shifting Left" mean?
Traditionally, security and compliance audits are executed late in the software lifecycle, often against already provisioned live resources in production. Finding misconfigurations at this stage is expensive, delays releases, and increases security risks.

Shifting Left means moving those security checks as close to the creation of code as possible:
* Local Checks: Developers can run compliance scans directly on their machines before committing code.
* Pull Request Validation: Scans are automatically triggered when pull requests are opened, blocking non-compliant configurations before they ever reach our main branch.
* Continuous Integration: Security scans operate as automated quality gates in our continuous delivery pipeline, ensuring consistency across environments.

### Enhancing the developer lifecycle
We believe security shouldn't slow developers down. This repository aims to enhance the daily development workflows for external projects through:
* Frictionless Local Scanning: Other projects can run the pre-packaged Checkov Docker images locally against their codebase with a single command (using `docker run`). This completely eliminates the need for developers to install Python, manage custom packages, or pull down policy directories manually on their local machines.
* Unified Rule Consistency: By using the same pre-packaged Docker image locally and in CI/CD, developers get the *exact same* compliance feedback on their machines as they do in pull requests and final deployments. This makes security audits predictable and prevents last-minute release blocks.
* Rich Pipeline Dashboards: Using standardised JUnit XML output for test results. This allows platforms like GitHub and Azure DevOps to parse failures and display them directly on native, interactive test dashboards and keeping developer feedback loops fast and clean.

### What is Policy-as-Code?
Policy-as-Code (PaC) is the practice of defining, managing, and enforcing security and compliance rules using structured, human-readable files (like YAML).

Instead of relying on manual security checklists, PDFs, or out-of-band reviews, we codify the standards. This allows compliance checks to be version-controlled, automatically validated, and scaled across any number of landing zones seamlessly. It acts as the foundational enabler that allows security to be automated and integrated directly into the developer workflow.
