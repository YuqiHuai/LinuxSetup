#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/bin"

for file in "$ROOT/bin/"*; do
    name=$(basename "$file")
    ln -sf "$file" "$HOME/.local/bin/$name"
done

echo "Personal scripts installed"
