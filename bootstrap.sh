#!/bin/bash
set -euo pipefail

required_dirs=(
    "/srv/infra"
    "/srv/infra/containers"
    "/srv/infra/configs"
    "/srv/infra/media"
    "/srv/infra/logs"
    "/srv/infra/backups"
    "/srv/infra/samba"
    "/srv/infra/repos"
)

echo "Creating infrastructure folders..."
for dir in "${required_dirs[@]}"
do
    mkdir -p "$dir"
    chmod 2755 "$dir"
done

echo "Folders created."
