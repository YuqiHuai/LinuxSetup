#!/usr/bin/env bash
set -euo pipefail

NVIM_CONFIG="$HOME/.config/nvim"

if [ -s "$NVIM_CONFIG/init.lua" ]; then
  echo "Neovim config already exists, skipping LazyVim install"
  exit 0
fi

if [ -d "$NVIM_CONFIG" ]; then
  backup="$NVIM_CONFIG.backup.$(date +%Y%m%d%H%M%S)"
  echo "Backing up incomplete Neovim config to $backup"
  mv "$NVIM_CONFIG" "$backup"
fi

echo "Installing LazyVim..."

git clone https://github.com/LazyVim/starter "$NVIM_CONFIG"

rm -rf "$NVIM_CONFIG/.git"

echo "LazyVim installed"
echo "Run 'nvim' to finish plugin installation"
