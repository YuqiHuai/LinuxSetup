#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if command -v uv >/dev/null; then
    echo "uv already installed"
    exit 0
fi

echo "Installing uv..."

curl -LsSf https://astral.sh/uv/install.sh | sh

if ! command -v uv >/dev/null; then
    echo "uv install did not create a usable uv executable" >&2
    exit 1
fi

echo "uv installed"
