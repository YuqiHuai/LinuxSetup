#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if command -v poetry >/dev/null; then
    echo "Poetry already installed"
else
    echo "Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
fi

if ! command -v poetry >/dev/null; then
    echo "Poetry install did not create a usable poetry executable" >&2
    exit 1
fi

echo "Configuring Poetry..."

poetry config virtualenvs.in-project true

echo "Poetry setup complete"
