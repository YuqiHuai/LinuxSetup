#!/usr/bin/env bash
set -euo pipefail

if command -v eza >/dev/null; then
  echo "eza already installed"
  exit 0
fi

echo "Installing eza..."

sudo mkdir -p /etc/apt/keyrings

wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
  | sudo gpg --dearmor -o /etc/apt/keyrings/eza.gpg

echo "deb [signed-by=/etc/apt/keyrings/eza.gpg] \
https://deb.gierens.de stable main" \
| sudo tee /etc/apt/sources.list.d/eza.list

sudo apt update
sudo apt install -y eza