#!/usr/bin/env bash
set -euo pipefail

ARGS=()

ARGS+=(
  "--external-checks-dir"
  "${CHECKOV_POLICIES}"
)

# Usage:
#   -e EXTRA_CHECKOV_POLICY_DIRS=/team-policies:/experimental-policies
if [ -n "${EXTRA_CHECKOV_POLICY_DIRS:-}" ]; then
  IFS=':' read -ra DIRS <<< "${EXTRA_CHECKOV_POLICY_DIRS}"

  for dir in "${DIRS[@]}"; do
    if [ -d "${dir}" ]; then
      ARGS+=(
        "--external-checks-dir"
        "${dir}"
      )
    fi
  done
fi

exec checkov "${ARGS[@]}" "$@"