---
layout: page
title: Policy catalogue
includeInBreadcrumbs: true
order: 4
eleventyNavigation:
  key: Policy catalogue
---

This document serves as a central repository for all custom Checkov policies developed. It provides visibility into existing policies, their purpose, and policies currently under development or consideration.

## Catalogue metadata glossary

| Column          | Description                                                                                                         |
|:----------------|:--------------------------------------------------------------------------------------------------------------------|
| **Policy ID**   | The unique identifier for the rule (e.g., `DFE_CIP_0001`).                                                          |
| **Policy Name** | A short, descriptive title of the rule's intent.                                                                    |
| **Description** | A brief explanation of the logic and reasoning behind the rule.                                                     |
| **Category**    | The functional area or compliance standard the rule addresses.                                                      |
| **Status**      | The current lifecycle stage: `Active` (implemented), `Draft` (in development), or `Proposed` (under consideration). |


## Common policies

These policies apply to both landing zones (CIP and ELZ).


| Policy ID    | Policy Name                                               | Description                                                                                                                                  | Category | Status |
|:-------------|:----------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------|:---------|:-------|
| DFE_CMN_0001 | Ensure all Azure resources have an `Environemnt` tag      | Ensures that all resources have the mandatory `Environment` tag for environment identification and value is one of `Dev`, `Test`, or `Prod`. | Tags     | Active |
| DFE_CMN_0002 | Ensure all Azure resources have an `Service Offering` tag | Ensures that all resources have the mandatory `Service Offering` tag for business reporting                                                  | Tags     | Active |
| DFE_CMN_0003 | Ensure all Azure resources have an `Product` tag          | Ensures that all resources have the mandatory `Product` tag for business reporting.                                                          | Tags     | Active |
| DFE_CMN_0004 | Azure Key Vault should use RBAC permission model          | Enable RBAC permission model across Key Vaults. Learn more at: https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-migration      | IAM      | Active |
| DFE_CMN_0005 | Deny Cosmos DB                                            | Deny Cosmos.                                                                                                                                 | Security | Active |
| DFE_CMN_0006 | Daily Quota Limit is set for Log Analytics Workspace      | Ensures Daily Quota is set                                                                                                                   | Logging  | Active |

## CIP policies (Cloud Infrastructure Platform)

These policies are specific to the Cloud Infrastructure Platform requirements and standards.

| Policy ID     | Policy Name                                                                                                                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Category   | Status   |
|:--------------|:-------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|:---------|
| DFE_CIP_0001  | Enforce all resources have correct location                                                                                    | Enforce all resources have correct location (West Europe or North Europe)                                                                                                                                                                                                                                                                                                                                                                                                                                             | Security   | Active   |


## ELZ policies (Enterprise Landing Zone)

These policies are specific to the Enterprise Landing Zone requirements and standards.

| Policy ID    | Policy Name                                                      | Description                                                                                                                                                                          | Category   | Status |
|:-------------|:-----------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------|:-------|
| DFE_ELZ_0001 | Naming standards - resource groups                               | ELZ has specific naming standards around resource groups.                                                                                                                            | Naming     | Active |
| DFE_ELZ_0003 | Naming standards - key vault                                     | ELZ has specific naming standards around key vaults.                                                                                                                                 | Naming     | Active |
| DFE_ELZ_0004 | Blocked resources                                                | Identify and block restricted resources (e.g., AI, foundry) unless exempted.                                                                                                         | Governance | Active |
| DFE_ELZ_0002 | Region reminders                                                 | Ensure resources are provisioned in `uksouth` (ELZ standard).                                                                                                                        | Governance | Active |
| DFE_ELZ_0005 | Diagnostic logs in Azure AI services resources should be enabled | Enable logs for Azure AI services resources. This enables you to recreate activity trails for investigation purposes, when a security incident occurs or your network is compromised | Security   | Active |

