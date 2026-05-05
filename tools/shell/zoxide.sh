#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if command -v zoxide >/dev/null; then
    echo "zoxide already installed"
    exit 0
fi

curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

if ! command -v zoxide >/dev/null; then
    echo "zoxide install did not create a usable zoxide executable" >&2
    exit 1
fi
