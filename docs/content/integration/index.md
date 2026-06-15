---
layout: page
title: Integration guide
includeInBreadcrumbs: true
order: 3
eleventyNavigation:
  key: Integration
---

This guide outlines how to integrate the custom Checkov policies into your Azure infrastructure codebases. 

The custom policies are pre-packaged and published as two Docker images to the GitHub Container Registry (GHCR):
- CIP Policies: `ghcr.io/dfe-digital/checkov-cip:latest`
- ELZ Policies: `ghcr.io/dfe-digital/checkov-elz:latest`

These images are based on the official `bridgecrew/checkov` scanner and come pre-bundled with our custom policy suites and an automated entrypoint. This means you do not need to manage custom directories or append policy arguments manually.

> [!IMPORTANT]
> **Terraform Variables:** To ensure that Checkov correctly evaluates policy logic against computed variable values (like region locations, tags, and RBAC models), we highly recommend passing your `.tfvars` files to the scan. For more details on our recommended approach, please refer to the [Terraform Setup Guide](../integration/terraform-setup/).

## Local development

If you want to run the custom policies locally against your own infrastructure code, you can use Docker.

Navigate to the directory containing your Terraform files and execute the container, passing your environment-specific variables using the `--var-file` parameter:

```bash
docker run --rm \
  -v "$(pwd)":/tf \
  ghcr.io/dfe-digital/checkov-cip:latest \
  -d /tf \
  --var-file /tf/environments/production.tfvars \
  --output cli
```

> [!TIP]
> Replace `checkov-cip` with `checkov-elz` if your codebase is deploying to an Enterprise Landing Zone (ELZ) subscription.

## GitHub workflows

You can integrate these custom Checkov scans into your CI/CD pipelines on GitHub. Below is an example GitHub Actions workflow (`.github/workflows/checkov.yml`) that runs on pushes to `main`.

```yaml
name: Checkov Scan

on:
  push:
    branches: [ "main" ]

jobs:
  checkov:
    name: Checkov Scan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Source Code
        uses: actions/checkout@v4

      - name: Run CIP Policies
        run: |
          docker run --rm \
            -v "${{ github.workspace }}:/tf" \
            ghcr.io/dfe-digital/checkov-cip:latest \
            -d /tf \
            --var-file /tf/environments/production.tfvars \
            --soft-fail \
            --output cli
```

## Azure DevOps pipelines

To run these checks inside an Azure DevOps pipeline, you can run the Docker container via a `script` step in your `azure-pipelines.yml` file.

```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - checkout: self
    displayName: 'Checkout Code'

  - script: |
      docker run --rm \
        -v "$(System.DefaultWorkingDirectory):/tf" \
        ghcr.io/dfe-digital/checkov-elz:latest \
        -d /tf \
        --var-file /tf/environments/production.tfvars \
        --soft-fail \
        --output cli
    displayName: 'Run ELZ Checkov Scan'
```

## Recommendations

To maintain high security and compliance across environments, we recommend adopting the following scanning strategies in your pipelines:

###  Run PR builds 
When running pull request validations, we strongly recommend executing the Checkov scan using your production `.tfvars` file (e.g. `--var-file /tf/environments/production.tfvars`). Since production environments are subject to the strictest security controls, scanning against production variables ensures that any compliance issues are caught and resolved before the code is merged into the main branch.

### Pre-deployment scans
For comprehensive coverage, teams should also execute Checkov scans directly inside the deployment release pipeline immediately before applying changes. This "belt and braces" verification ensures no environment-specific configuration drifts are introduced. 

This can be done using two approaches:
* Scan target environment tfvars: Run the scan pointing directly to the target environment's variable file (e.g., `--var-file /tf/environments/staging.tfvars`).
* Scan the compiled Terraform Plan: For absolute fidelity, generate a Terraform plan, output it as JSON, and scan the JSON plan. This ensures Checkov evaluates the exact physical resources that will be provisioned by Terraform.
  ```bash
  terraform plan -out=tfplan
  terraform show -json tfplan > tfplan.json

  docker run --rm \
    -v "$(pwd)":/tf \
    ghcr.io/dfe-digital/checkov-cip:latest \
    -f /tf/tfplan.json \
    --output cli
  ```

> [!WARNING]
> **Lower Environments:** Depending on your configuration, standard Checkov policies might trigger violations in lower environments (e.g., if development/test environments are scaled down to save costs, lacking production-level resilience). Be cautious that this might prompt teams to ignore/skip warnings that are critical for production configuration. Consider using the `--soft-fail` option for lower environment pipelines rather than permanently suppressing rules.

## Reporting test results

By default, policy violations will fail the build step. A highly recommended pattern is to output Checkov results in JUnit XML format, combine it with the `--soft-fail` option, and use native CI/CD test publishing tasks to display violations inside your pull request or build dashboard. This keeps the build step green while providing full visibility into violations on your platform.

To set up rich test dashboards and reporting for GitHub Actions or Azure DevOps, refer to our [Reporting Results Guide](../integration/reporting-results/).

## Advanced options

If you have additional repository-specific custom policies that you want to run *alongside* the custom policies, you can mount them to the container and specify them using the `EXTRA_CHECKOV_POLICY_DIRS` environment variable.

The folder paths inside the environment variable are colon-separated (`:`) and must match the directory paths mounted inside the container.

```bash
docker run --rm \
  -v "$(pwd)":/tf \
  -v "$(pwd)/local-policies:/extra-policies" \
  -e EXTRA_CHECKOV_POLICY_DIRS=/extra-policies \
  ghcr.io/dfe-digital/checkov-cip:latest \
  -d /tf \
  --var-file /tf/environments/production.tfvars \
  --output cli
```
