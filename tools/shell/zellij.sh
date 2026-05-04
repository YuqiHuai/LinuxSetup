#!/usr/bin/env bash
set -euo pipefail

if command -v zellij >/dev/null; then
  echo "Zellij already installed"
  exit 0
fi

echo "Installing Zellij..."

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)
    ZELLIJ_TARGET="x86_64-unknown-linux-musl"
    ;;
  aarch64|arm64)
    ZELLIJ_TARGET="aarch64-unknown-linux-musl"
    ;;
  *)
    echo "Unsupported architecture for Zellij: $ARCH" >&2
    exit 1
    ;;
esac

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fL "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ZELLIJ_TARGET}.tar.gz" \
  -o "$TMP_DIR/zellij.tar.gz"

tar -xzf "$TMP_DIR/zellij.tar.gz" -C "$TMP_DIR"

sudo install "$TMP_DIR/zellij" /usr/local/bin/zellij

echo "Zellij installed"
