#!/usr/bin/env bash
set -euo pipefail

if [ -f /.dockerenv ]; then
    echo "Running inside Docker container, skipping VS Code install"
    exit 0
fi

if command -v code >/dev/null; then
    echo "Visual Studio Code already installed"
    exit 0
fi

echo "Installing Visual Studio Code..."

sudo apt-get update
sudo apt-get install -y apt-transport-https wget gpg

TMP_KEY="$(mktemp)"
trap 'rm -f "$TMP_KEY"' EXIT

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$TMP_KEY"
sudo install -D -o root -g root -m 644 "$TMP_KEY" /usr/share/keyrings/microsoft.gpg

sudo tee /etc/apt/sources.list.d/vscode.sources >/dev/null <<'SOURCES'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
SOURCES

sudo apt-get update
sudo apt-get install -y code

echo "Visual Studio Code installed"
