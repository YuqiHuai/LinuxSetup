#!/usr/bin/env bash
set -euo pipefail

if command -v lazygit >/dev/null; then
  echo "lazygit already installed"
  exit 0
fi

echo "Installing lazygit..."

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)
    LAZYGIT_ARCH="x86_64"
    ;;
  aarch64|arm64)
    LAZYGIT_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture for lazygit: $ARCH" >&2
    exit 1
    ;;
esac

LAZYGIT_VERSION=$(curl -s \
https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
| grep tag_name | cut -d '"' -f 4)

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fL -o "$TMP_DIR/lazygit.tar.gz" \
"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION#v}_Linux_${LAZYGIT_ARCH}.tar.gz"

tar -C "$TMP_DIR" -xf "$TMP_DIR/lazygit.tar.gz" lazygit
sudo install "$TMP_DIR/lazygit" /usr/local/bin
