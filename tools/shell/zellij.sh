#!/usr/bin/env bash
set -euo pipefail

if command -v zellij >/dev/null; then
  echo "Zellij already installed"
  exit 0
fi

echo "Installing Zellij..."

curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz \
  -o /tmp/zellij.tar.gz

tar -xzf /tmp/zellij.tar.gz -C /tmp

sudo mv /tmp/zellij /usr/local/bin/zellij

rm /tmp/zellij.tar.gz

echo "Zellij installed"