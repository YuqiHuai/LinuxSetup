#!/usr/bin/env bash
set -euo pipefail

if command -v poetry >/dev/null; then
    echo "Poetry already installed"
else
    echo "Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
fi

# ensure poetry is in PATH for this session
export PATH="$HOME/.local/bin:$PATH"

echo "Configuring Poetry..."

poetry config virtualenvs.in-project true

echo "Poetry setup complete"