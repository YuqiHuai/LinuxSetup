#!/usr/bin/env bash
set -euo pipefail

NVIM_CONFIG="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG" ]; then
  echo "Neovim config already exists, skipping LazyVim install"
  exit 0
fi

echo "Installing LazyVim..."

git clone https://github.com/LazyVim/starter "$NVIM_CONFIG"

rm -rf "$NVIM_CONFIG/.git"

echo "LazyVim installed"
echo "Run 'nvim' to finish plugin installation"