#!/usr/bin/env bash
set -euo pipefail

if command -v zoxide >/dev/null; then
    echo "zoxide already installed"
    exit 0
fi

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash