---
layout: page
title: Getting started
includeInBreadcrumbs: true
order: 1
eleventyNavigation:
  key: Getting started
---

This guide provides the necessary steps to set up your local development environment so you can start contributing to the repository.

> [!IMPORTANT] 
> **Note**: If you are looking for how to use these policies in your own infrastructure codebase, please refer to the [Integration guide](../integration/).

## Prerequisites

To run these policy tests locally, you need the following tools installed on your machine.

**GNU Make:** Used to orchestrate and run the test suites via a simple `Makefile`.
* macOS: Recommended via Apple Command Line Tools (`xcode-select --install`) or Homebrew.
* Windows: Recommended via WSL (Windows Subsystem for Linux), Git Bash, or Chocolatey/Winget.

**Docker Engine:** Required to run the Checkov scanner container without needing to manage local Python environments.
* macOS: Colima (CLI-only) or OrbStack are highly recommended for best performance and battery efficiency.
* Windows: Rancher Desktop is recommended if you prefer a visual GUI interface. Alternatively, running open-source Docker directly inside a WSL 2 distribution provides a fantastic, lightweight terminal experience.

**Terraform CLI:** Required if you want to use the local formatting command (`make tf-fmt`) or work directly with the Terraform test configurations.
* macOS: Recommended via Homebrew (`brew install terraform`).
* Windows: Recommended via Chocolatey (`choco install terraform`), winget (`winget install HashiCorp.Terraform`), or via manually downloading the binary from HashiCorp.

**Node.js (v22+ LTS) & npm:** Required if you want to run and preview the documentation site locally. We recommend using an active Long-Term Support (LTS) release of Node.js.
* macOS: Recommended via Homebrew (`brew install node`) or nvm.
* Windows: Recommended via Node.js Installer, winget (`get-content` / `winget install OpenJS.NodeJS`), or nvm-windows.

## Clone the repository

Clone the repository to your local machine and navigate into the project directory:

```bash
git clone https://github.com/DFE-Digital/dfe-checkov-policies.git
cd dfe-checkov-policies
```

## Running policy tests locally

When developing new policies, you must ensure both compliant and non-compliant test cases work as expected. These are typically defined as resource blocks (often named or suffixed with `pass` and `fail`) inside a single Terraform test file named after the policy (e.g., `tests/cip/DFE_CIP_0001.tf`).

We use `make` to orchestrate running Checkov inside Docker easily.

**Run tests for a policy set:**
You can run the default tests (which target the `development` environment) using:

```bash
# Run Checkov tests for the CIP policy set
make test-cip

# Run Checkov tests for the ELZ policy set
make test-elz
```

**Run tests for a specific policy and environment:**
If you want to run tests for a specific policy set or target a different environment configuration (e.g., `production`, `staging`, `test`), use the `POLICY` and `ENV` variables:

```bash
make test POLICY=cip ENV=production
make test POLICY=elz ENV=staging
```

**Format Terraform test files:**
You can also format all Terraform files in the repository:

```bash
make tf-fmt
```

## Running the documentation site locally

Our documentation site is built using Eleventy (11ty) and styled with the [X-GOVUK theme](https://govuk-eleventy-plugin.x-govuk.org/). If you want to run and preview the documentation site locally on your machine:

**Navigate to the docs directory:**
```bash
cd docs
   ```

**Install Node.js dependencies:**
```bash
npm install
```

**Start the local development server:**
```bash
npm run start
```

The server will automatically watch for changes in the `docs/content/` directory and hot-reload your browser as you make edits!
