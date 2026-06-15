# 🏫 DfE Checkov policies

This repository contains DfE Checkov policies, examples, and CI integrations for scanning Azure Infrastructure-as-Code (IaC) across DfE landing zones (including CIP and ELZ subscriptions).

## 📖 Technical documentation

All system prerequisites, local setup instructions, integration examples, policy catalogues, and development guidelines are hosted on our [dedicated technical documentation site](https://dfe-digital.github.io/dfe-checkov-policies).

## 🚀 Future development roadmap

This repository is designed to grow and evolve as the central compliance scanner for DfE. Our future plans include:
* Landing Zone Policy Expansion: Continuously expanding custom rules for CIP (Cloud Infrastructure Platform) and ELZ (Enterprise Landing Zone) subscriptions.
* Bicep Policy Support: Introducing custom rules and compliance scanning for Bicep-based deployments.
* Multi-Framework Scans: Extending the policy scanner's reach beyond Terraform to evaluate other critical codebase elements, including:
  * ARM Templates
  * Dockerfiles
  * GitHub Workflows
  * Azure DevOps Pipelines

## 💬 Support & feedback

We welcome feedback, suggestions, and rule additions from across the DfE!

If you encounter a bug, have a feature request, or identify a policy gap that needs to be codified:
* Search first: Check our existing issues to see if it is already being tracked.
* Open an issue: Log a bug report or feature request on our [GitHub Issue Tracker](https://github.com/DFE-Digital/dfe-checkov-policies/issues).
* Contribute: If you want to develop or fix a policy yourself, please refer to the technical documentation site before opening a pull request.
