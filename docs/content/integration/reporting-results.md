---
layout: page
title: Reporting results guide
includeInBreadcrumbs: true
order: 2
eleventyNavigation:
  key: Reporting results
  parent: Integration
---

When running security scans in a CI/CD pipeline, the default behaviour is to fail the build step when a policy violation is detected. However, a highly recommended pattern is to combine the Soft Fail option with JUnit XML test reporting.

This approach allows the pipeline step to complete successfully, while generating a structured XML test report. Native CI/CD test reporting tools can then parse this report, display individual policy violations inside your pull request or build dashboard, and dynamically decide whether to block the merge.

## How it works

1. Add Soft Fail: Append `--soft-fail` to your Checkov command so that a failing check returns an exit code of `0`. This keeps the pipeline step from crashing.
2. Output JUnit XML: Append `--output junitxml` to direct Checkov to output its scan results in standard JUnit XML format.
3. Redirect Output: Redirect the output to a file inside your repository workspace (e.g., `> results.xml`).
4. Publish Results: Use your CI/CD platform's native test publishing task to upload and parse the XML file.

## GitHub workflows

In GitHub Actions, you can output Checkov results as a JUnit XML file and use the `dorny/test-reporter` action to display failures directly inside your Pull Request under a "Test Results" tab.

### Example workflow

```yaml
name: Checkov Scan

on:
  push:
    branches: [ "main" ]

env:
  CHECKOV_RESULTS: checkov-reports

jobs:
  checkov:
    name: Checkov Scan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Source Code
        uses: actions/checkout@v4

      - name: Create Reports Directory
        run: mkdir -p ${{ env.CHECKOV_RESULTS }}

      - name: Run CIP Policies
        run: |
          docker run --rm \
            -v "${{ github.workspace }}:/tf" \
            ghcr.io/dfe-digital/checkov-cip:latest \
            -d /tf \
            --var-file /tf/environments/production.tfvars \
            --soft-fail \
            --output junitxml > ${{ env.CHECKOV_RESULTS }}/results.xml

      - name: Publish Checkov results
        uses: dorny/test-reporter@a43b3a5f7366b97d083190328d2c652e1a8b6aa2
        if: always()
        with:
          name: Checkov Scan Results
          path: ${{ github.workspace }}/${{ env.CHECKOV_RESULTS }}/results.xml
          reporter: java-junit
          fail-on-error: true
```

## Azure DevOps pipelines

In Azure DevOps, you can run the Docker container to output a JUnit XML file, and use the `PublishTestResults@2` task to populate the "Tests" tab of the release or build run.

### Example pipeline

```yaml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

variables:
  terraform_directory: '$(System.DefaultWorkingDirectory)'

steps:
  - checkout: self
    displayName: 'Checkout Code'

  - script: |
      docker run --rm \
        -v "$(terraform_directory):/tf" \
        ghcr.io/dfe-digital/checkov-elz:latest \
        -d /tf \
        --var-file /tf/environments/production.tfvars \
        --soft-fail \
        --output junitxml > $(terraform_directory)/CheckovReport.xml
    displayName: 'Run ELZ Checkov Scan'

  - task: PublishTestResults@2
    inputs:
      testRunTitle: "Checkov_ScanResults"
      failTaskOnFailedTests: true
      testResultsFormat: "JUnit"
      testResultsFiles: "CheckovReport.xml"
      searchFolder: "$(terraform_directory)"
    displayName: "Publish results"
    continueOnError: false
```
