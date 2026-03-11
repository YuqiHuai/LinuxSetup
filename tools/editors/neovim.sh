#!/usr/bin/env bash
set -euo pipefail

if command -v nvim >/dev/null; then
  echo "Neovim already installed"
  exit 0
fi

echo "Installing Neovim..."

curl -LO https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

rm nvim-linux-x86_64.tar.gz

echo "Neovim installed"