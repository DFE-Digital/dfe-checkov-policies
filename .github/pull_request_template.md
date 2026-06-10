## Summary
<!-- Provide a clear and concise summary of the changes in this PR. -->

## Related Issues/Tickets
<!-- Link any related Jira tickets or GitHub issues. -->
- Fixes: DFE-

## Type of Change
- [ ] New policy (feat)
- [ ] Policy update (refactor)
- [ ] Bug fix (fix)
- [ ] Documentation update (docs)
- [ ] Test update (test)

## Policy Details
<!-- Only complete if adding or updating a policy -->
- **Policy ID:** `DFE_<ZONE>_<NUMBER>`
- **Scope:** (e.g., Shared, CIP, ELZ)
- **Description:** 

## Checklist
- [ ] My commit messages follow the **Conventional Commits** methodology.
- [ ] I have added **pass.tf** and **fail.tf** test cases in the correct directory (`tests/<zone>/<policy_id>/`).
- [ ] I have verified that all tests pass locally using Checkov.
- [ ] I have updated the relevant documentation in the `docs/` folder.
- [ ] I have checked for any sensitive information or secrets in my code.

## Testing Performed
<!-- Describe the testing you performed to verify your changes. Include any logs or screenshots if applicable. -->
```bash
# Example test command used
docker run --rm -v "$(pwd)":/repo -w /repo bridgecrew/checkov:latest -d tests/<zone>/<policy_id> --external-checks-dir policies/<zone>
```

## Reviewers
<!-- Assign or tag specific reviewers if required. -->
