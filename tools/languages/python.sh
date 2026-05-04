#!/usr/bin/env bash
set -euo pipefail

if command -v python3 >/dev/null; then
    echo "Python 3 already installed"
    exit 0
fi

echo "Installing Ubuntu python3..."

sudo apt update
sudo apt install -y python3 python3-venv python3-dev

echo "Python 3 installed"
