# Contributing to DfE Checkov Policies

Thank you for your interest in contributing to the DfE Checkov Policies repository! We welcome contributions to help improve and expand our policy coverage.

This document outlines the process for contributing to this project, ensuring a consistent and safe approach to adding policies, tests, and documentation.

## Code of Conduct

This project is governed by the DfE Code of Conduct. By participating, you are expected to uphold this code. Please ensure interactions remain professional, inclusive, and collaborative.

## How to Contribute

### Reporting Issues

* **Search first:** Check if the issue has already been reported in the issue tracker.
* **Be specific:** When opening a new issue, clearly describe the bug, feature request, or policy enhancement.
* **Include examples:** If reporting a bug, include the Checkov version, Terraform snippets (if applicable), and clear steps to reproduce the issue.

### Pull Request Process

1. **Branch:** Create a new branch from `main` (e.g., `feature/add-cip-storage-policy` or `fix/elz-network-policy`).
2. **Develop:** Implement your policy or fix, ensuring you follow the [Policy Development](docs/policy-development.md) guidelines.
3. **Test:** Write comprehensive tests for your changes and run the test suite locally. **All tests must pass.**
4. **Commit:** Follow the [Commit Message Guidelines](#commit-message-guidelines). Small, focused commits are preferred.
5. **Open PR:** Submit a Pull Request against the `main` branch. Provide a clear title, detailed description, and a link to any relevant Jira tickets or issues.
6. **Review:** Assign reviewers as required. PRs will be evaluated for correctness, naming conventions, and test coverage.

## Guidelines for Contributing

### Policy Development & Testing

For comprehensive instructions on how to create a new Checkov policy, including directory structure, required metadata, naming conventions, and how to write pass/fail tests, please refer to our [Policy Development Guide](docs/policy-development.md).

### Commit Message Guidelines

We use [conventional commits](https://www.conventionalcommits.org/) to maintain a clear and readable history:

* **Add new policy:** `feat(cip): add CKV_DFE_CIP_0001_storage_private`
* **Update existing policy:** `refactor(elz): update CKV_DFE_ELZ_0002_private_endpoint`
* **Add tests:** `test: add pass/fail tests for CKV_DFE_CIP_0001`
* **Fix bug:** `fix: resolve false positive in CKV_DFE_CIP_0005`
* **Update docs:** `docs: update policy development guidelines`

### Documentation

Clear documentation ensures policies are understood and used correctly.

* If adding or significantly changing policies, update relevant documentation in `docs/`.
* Provide clear descriptions within the policy YAML or Python files.
* If necessary, add complex usage examples to help users understand how to comply with the policy.
