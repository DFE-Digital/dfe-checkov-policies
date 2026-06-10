# 🏫 DfE Checkov Policies

This repository contains **DfE Checkov policies, examples, and CI integrations** for scanning Azure Infrastructure-as-Code (IaC). It provides:

* Custom policy structure for DfE
* CI examples for GitHub and Azure DevOps

The repository is designed to evolve into the **central source of Checkov policies for DfE landing zones**, including **CIP and ELZ subscriptions**.

## 🔍 What is Checkov?

[Checkov](https://www.checkov.io/) is an open-source Infrastructure-as-Code security scanner that detects security and compliance misconfigurations. Checkov supports many frameworks including:

* Terraform
* Bicep
* ARM templates
* Kubernetes
* CloudFormation
* Dockerfiles

## 🛠️ Prerequisites

To run these policy tests locally, you need the following tools installed on your machine.

### 1. GNU Make
Used to orchestrate and run the test suites via a simple `Makefile`.
* **macOS:** Recommended via **Apple Command Line Tools** (`xcode-select --install`) or **Homebrew**.
* **Windows:** Recommended via **WSL (Windows Subsystem for Linux)**, **Git Bash**, or **Chocolatey/Winget**.

### 2. Docker Engine
Required to run the Checkov scanner container without needing to manage local Python environments.
* **macOS:** **Colima** (CLI-only) or **OrbStack** are highly recommended for best performance and battery efficiency.
* **Windows:** **Rancher Desktop** is recommended if you prefer a visual GUI interface. Alternatively, running open-source **Docker directly inside a WSL 2 distribution** provides a fantastic, lightweight terminal experience.

## 📁 Repository Structure

```
docs/            # Documentation and guides
policies/        # Shared, CIP, and ELZ custom Checkov policies
tests/           # Pass/fail tests for policies
```

## 🧩 Policies

Contains custom Checkov policies developed by DfE. Policies are organised into:

* CIP: Policies that are specific to **CIP subscriptions**. 
* ELZ: Policies that are specific to **ELZ subscriptions**.

## 🚀 Future Development

This repository will evolve to include:

* DfE custom Checkov policies
* landing zone specific policies for CIP and ELZ
* expanded documentation

## 🔗 Additional Resources

Checkov documentation: https://www.checkov.io/  
Checkov GitHub repository: https://github.com/bridgecrewio/checkov
