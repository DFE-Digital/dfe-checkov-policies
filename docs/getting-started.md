# 🚀 Getting Started with DfE Checkov Policies

This guide provides the necessary steps to set up your local development environment so you can start contributing to the DfE Checkov Policies repository.

> **Note:** If you are looking for how to use these policies in your own infrastructure codebase, please refer to the relevant documentation.

## Prerequisites

Before you begin, ensure you have the following installed:
* **Git:** For version control.
* **Docker:** Required for running Checkov locally against the test cases.
* **Python 3.9+ & pip (Optional):** If you are writing or testing Python-based custom policies.
* **PowerShell (Optional):** For running the provided test scripts on Windows/macOS/Linux.

## 1. Clone the Repository

Clone the repository to your local machine and navigate into the project directory:

```bash
git clone https://github.com/DFE-Digital/dfe-checkov-policies.git
cd dfe-checkov-policies
```

## 2. Running Policy Tests Locally

When developing new policies, you must ensure both compliance (`pass.tf`) and non-compliance (`fail.tf`) test cases work as expected.

You can run Checkov via Docker to test a specific policy locally.

**On Linux/macOS:**
```bash
docker run --rm \
  -v "$(pwd)":/repo \
  -w /repo \
  bridgecrew/checkov:latest \
  -d tests/<zone>/<policy_name> \
  --external-checks-dir policies/<zone>
```

**On Windows (Command Prompt):**
```cmd
docker run --rm ^
  -v "%cd%:/repo" ^
  -w /repo ^
  bridgecrew/checkov:latest ^
  -d tests/<zone>/<policy_name> ^
  --external-checks-dir policies/<zone>
```

**Using the automated test script (PowerShell):**
We provide a PowerShell script to run the test suite automatically.
```powershell
.\scripts\run-policy-tests.ps1
```

## 3. Next Steps

Now that your environment is set up, you are ready to start writing policies!

* Read our [Contribution Guidelines](../CONTRIBUTING.md) to understand the pull request process, commit standards, and policy development rules.
* Check out [Policy Development](policy-development.md) for detailed instructions on writing your first policy.
