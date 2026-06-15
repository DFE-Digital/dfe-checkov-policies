---
layout: page
title: Policy development guide
includeInBreadcrumbs: true
order: 5
eleventyNavigation:
  key: Policy development
---

This repository operates on the principle of convention over configuration. Our test suite execution and custom policy loaders depend on strict, consistent naming patterns to automatically discover, match, and run tests. Because of this, following our naming conventions and directory structure is absolutely essential.

This guide explains how to create, name, and structure new Checkov policies for the repository.

## Directory structure

Policies and their corresponding tests are organised by the environment or "zone" they apply to.

* `policies/<zone>/`: Contains the actual policy definitions in YAML format (`policies/cip/` or `policies/elz/`).
* `tests/<zone>/`: Contains the Terraform configuration files used to test policies (`tests/cip/` or `tests/elz/`).

## Naming conventions

To ensure consistency across the repository, all policies must adhere to strict naming conventions.

### Policy IDs
Every policy requires a unique ID. IDs must follow this format `DFE_<ZONE>_<NUMBER>`.

* `DFE`: Indicates this is a Department for Education custom policy.
* `<ZONE>`: The target environment scope, such as `CIP` or `ELZ`.
* `<NUMBER>`: A 4-digit sequential identifier (e.g., `0001`, `0002`).

*Example ID:* `DFE_CIP_0001`

> [!IMPORTANT]
>**Note:** Checkov automatically prefixes custom YAML IDs with `CKV_` internally, but you should define them as `DFE_...` in your metadata.

### File naming
* Policy Files: Should be named identically to the Policy ID (`policies/cip/DFE_CIP_0001.yaml`).
* Test Files: Test configurations should be named identically to the Policy ID with a `.tf` extension, located directly in the zone directory (`tests/cip/DFE_CIP_0001.tf`).

### Policy metadata

Every policy must include clear metadata describing its purpose. For YAML policies:

```yaml
metadata:
  name: "Ensure all Azure resources have correct location" # A clear, descriptive title
  id: "DFE_CIP_0001"                                       # The unique Policy ID
  category: "GOVERNANCE"                                   # An appropriate Checkov category
```

## Creating a new policy (step-by-step)

Follow these steps when contributing a new policy to the repository:

### Step 1: Define the policy

Create the policy file in the appropriate directory. Policies in this repository are written in YAML format.

Example YAML Policy (`policies/cip/DFE_CIP_0001.yaml`):
```yaml
metadata:
  name: "Enforce all resources have correct location"
  id: "DFE_CIP_0001"
  category: "GOVERNANCE"
definition:
  cond_type: "attribute"
  resource_types:
    - "all"
  attribute: "location"
  operator: "within"
  value:
    - "westeurope"
    - "northeurope"
    - "West Europe"
    - "North Europe"
```

### Step 2: Create test cases

Robust testing is mandatory. Instead of creating individual folders, you must define your test cases in a single `.tf` file inside the appropriate zone folder (e.g., `tests/<zone>/<policy_id>.tf`).

Inside this file, you must define resource blocks representing both compliant and non-compliant configurations. Standardize your resource names or suffixes with `pass` and `fail` so it is clear what is being verified:

Example Test File (`tests/cip/DFE_CIP_0001.tf`):
```hcl
# Non-compliant test case - Location is UK South (Invalid)
resource "azurerm_resource_group" "fail" {
  name     = "${local.prefix}-resource-group"
  location = "UK South"
  tags     = local.common_tags
}

# Compliant test case - Location is West Europe (Valid)
resource "azurerm_resource_group" "pass" {
  name     = "${local.prefix}-resource-group"
  location = "West Europe"
  tags     = local.common_tags
}
```

### Step 3: Run the tests

Before submitting your PR, ensure your policy correctly identifies the non-compliant resources as failures and the compliant resources as passes.

For detailed instructions on running these tests locally, see the [Getting Started Guide](../getting-started/#2-running-policy-tests-locally).

### Step 4: Update the policy catalogue

Documentation is a key part of our standards. If you are adding a new policy or modifying an existing one, you must update the [Policy Catalogue](../policy-catalogue/) (`docs/content/policy-catalogue.md`) with its metadata.

Ensure you list:
* Policy ID: The format must be `DFE_<ZONE>_<NUMBER>` (e.g., `DFE_CIP_0001`).
* Policy Name: A short, descriptive title.
* Description: A brief explanation of the logic and rationale behind the rule.
* Category: An appropriate functional category (e.g., Tags, IAM, Naming, Security, Governance).
* Status: Set to `Active` (once merged/deployed), `Draft` (during active development), or `Proposed`.

## Writing python policies

While Checkov supports Python-based policies for highly complex logic, the standard format for this repository is YAML. If your policy requires Python-based inheritance, please check with the team before implementing to ensure consistency.
