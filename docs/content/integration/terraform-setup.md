---
layout: page
title: Terraform setup
includeInBreadcrumbs: true
order: 1
eleventyNavigation:
  key: Terraform setup
  parent: Integration
---

While Terraform doesn't enforce a single standard for managing variable inputs, we strongly recommend using `.tfvars` files for non-sensitive values, reserving other input methods strictly for true secrets.

## Why we recommend `.tfvars` files

Using `.tfvars` files (such as `production.tfvars` or `staging.tfvars`) provides several key benefits:

**Cognitive Adjacency:** Having variable values stored inside the repository right next to the infrastructure configurations makes them easier to find and work with. Developers do not need to navigate to external CI/CD tool settings (like GitHub Secrets or Azure DevOps Variable Groups) just to understand basic non-sensitive environment configurations.

**Easier to Reason About:** When variable files are tracked in source control, it is incredibly easy to audit, review, and track changes to environment configurations over time. You can view diffs during pull request reviews to see exactly what is changing in an environment.

**Scan Fidelity & Identical Local Testing:** Because `.tfvars` files live inside the repository, you can run security scans locally that are *identical* to those executed in CI/CD. This makes troubleshooting custom policy violations simple, as you can run the exact same `make` or `docker` commands on your machine.

## Handling secrets

We recommend reserving other variable injection methods, specifically environment variables (like `TF_VAR_db_password`) or CLI arguments (`-var="db_password=..."`), strictly for true secret values (e.g., API keys, database passwords, and connection strings) that must never be committed to source control.

## Example setup

Below is a recommended project structure for organising environment-specific `.tfvars` files:

```text
my-infrastructure-repo/
├── main.tf
├── variables.tf
├── outputs.tf
└── environments/
    ├── development.tfvars
    ├── staging.tfvars
    └── production.tfvars
```

### Defining your variables (`variables.tf`)

```hcl
variable "environment" {
  type        = string
  description = "The target deployment environment (e.g., dev, staging, prod)."
}

variable "location" {
  type        = string
  description = "The target Azure region."
  default     = "uksouth"
}
```

### Configuring values (`environments/production.tfvars`)

```hcl
environment = "prod"
location    = "uksouth"
```

### Scanning with Checkov

When scanning this configuration with Checkov, you must pass the relevant `.tfvars` file to the scanner so it can correctly evaluate policy rules against the computed values:

```bash
docker run --rm \
  -v "$(pwd)":/tf \
  ghcr.io/dfe-digital/checkov-cip:latest \
  -d /tf \
  --var-file /tf/environments/production.tfvars \
  --output cli
```
