#!/usr/bin/env bash
set -euo pipefail

if command -v nvim >/dev/null; then
  echo "Neovim already installed"
  exit 0
fi

echo "Installing Neovim..."

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)
    NVIM_ARCH="x86_64"
    ;;
  aarch64|arm64)
    NVIM_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture for Neovim: $ARCH" >&2
    exit 1
    ;;
esac

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fL -o "$TMP_DIR/nvim-linux-${NVIM_ARCH}.tar.gz" \
  "https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-${NVIM_ARCH}.tar.gz"

sudo rm -rf /opt/nvim-linux-"$NVIM_ARCH"
sudo tar -C /opt -xzf "$TMP_DIR/nvim-linux-${NVIM_ARCH}.tar.gz"

sudo ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

echo "Neovim installed"
