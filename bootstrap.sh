#!/bin/bash
set -euo pipefail

INFRA_ROOT=$(
  grep '^INFRA_ROOT=' .env |
  cut -d= -f2 |
  tr -d '"'
)

required_dirs=(
    "${INFRA_ROOT}"
    "${INFRA_ROOT}/containers"
    "${INFRA_ROOT}/configs"
    "${INFRA_ROOT}/media"
    "${INFRA_ROOT}/logs"
    "${INFRA_ROOT}/backups"
    "${INFRA_ROOT}/samba"
    "${INFRA_ROOT}/repos"
)

echo "Creating infrastructure folders..."
echo

for dir in "${required_dirs[@]}"
do  
    echo "Creating: $dir..."
    sudo mkdir -p "$dir"

    echo "Changing permissions..."
    sudo chmod 2755 "$dir"

    echo "Done."
    echo
done

echo "Folders created."
