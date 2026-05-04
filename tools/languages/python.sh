#!/usr/bin/env bash
set -euo pipefail

echo "Installing Ubuntu Python packages..."

sudo apt update
sudo apt install -y python3 python3-venv python3-dev

echo "Python packages installed"
