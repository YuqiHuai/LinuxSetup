#!/usr/bin/env bash
set -euo pipefail

IMAGE="ubuntu:24.04"

echo "Starting clean bootstrap test..."
echo

docker run -it --rm \
  -v "$PWD":/workspace \
  -w /workspace \
  "$IMAGE" \
  bash -c "
    set -e
    export DEBIAN_FRONTEND=noninteractive
    echo 'Updating apt...'
    apt update

    echo 'Installing minimal tools...'
    apt install -y sudo git curl

    echo 'Running bootstrap...'
    bash install.sh
  "

echo
echo "Bootstrap test finished successfully."