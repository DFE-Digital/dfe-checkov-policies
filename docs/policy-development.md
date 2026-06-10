# 📝 Policy Development Guide

This guide explains how to create, name, and structure new Checkov policies for the DfE Checkov Policies repository.

## 1. Directory Structure

Policies and their corresponding tests are organised by the environment or "zone" they apply to.

* **`policies/<zone>/`**: Contains the actual policy definitions (YAML or Python).
  * Example: `policies/cip/` or `policies/elz/`
* **`tests/<zone>/<policy_id>/`**: Contains the Terraform code used to test the policy.
  * Example: `tests/cip/DFE_CIP_0001/`

## 2. Naming Conventions

To ensure consistency across the repository, all policies must adhere to strict naming conventions.

### Policy IDs
Every policy requires a unique ID. IDs must follow this format:
`DFE_<ZONE>_<NUMBER>`

* **`DFE`**: Indicates this is a Department for Education custom policy.
* **`<ZONE>`**: The target environment scope, such as `CIP` or `ELZ`.
* **`<NUMBER>`**: A 4-digit sequential identifier (e.g., `0001`, `0002`).

*Example ID:* `DFE_CIP_0001`

*(Note: Checkov automatically prefixes custom YAML IDs with `CKV_` internally, but you should define them as `DFE_...` in your metadata.)*

### File Naming
* **Policy Files:** Should be named identically to the Policy ID.
  * Example: `policies/cip/DFE_CIP_0001.yaml`
* **Test Folders:** Should be named identically to the Policy ID.
  * Example: `tests/cip/DFE_CIP_0001/`

### Policy Metadata

Every policy must include clear metadata describing its purpose. For YAML policies:

```yaml
metadata:
  name: "Ensure all Azure resources have an 'env' tag" # A clear, descriptive title
  id: "DFE_CIP_0001"                                    # The unique Policy ID
  category: "GENERAL_SECURITY"                         # An appropriate Checkov category
```

## 3. Creating a New Policy (Step-by-Step)

Follow these steps when contributing a new policy to the repository:

### Step 1: Define the Policy

Create the policy file in the appropriate directory. You can write policies in YAML (for simple attribute checks) or Python (for complex logic).

**Example YAML Policy (`policies/cip/DFE_CIP_0001.yaml`):**
```yaml
metadata:
  name: "Ensure all Azure resources have an 'env' tag"
  id: "DFE_CIP_0001"
  category: "GENERAL_SECURITY"
definition:
  cond_type: "attribute"
  resource_types:
    - "all"
  attribute: "tags/env"
  operator: "exists"
```

### Step 2: Create Test Cases

Robust testing is mandatory. Create a new directory for your tests: `tests/<zone>/<policy_id>/`.

Inside this directory, you must create at least two files:
* **`pass.tf`**: Contains Terraform code that strictly complies with the policy.
* **`fail.tf`**: Contains Terraform code that violates the policy.

### Step 3: Run the Tests

Before submitting your PR, ensure your policy correctly passes and fails the test cases as expected.

For detailed instructions on running these tests locally, see the [Getting Started Guide](getting-started.md#2-running-policy-tests-locally).

## 4. Writing Python Policies

If your policy requires logic too complex for YAML, you can write it in Python. Python policies must inherit from `BaseResourceCheck` (or the appropriate Checkov base class) and implement the `scan_resource_conf` method. Ensure you register the check properly at the bottom of the file.
