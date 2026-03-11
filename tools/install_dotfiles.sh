#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for dir in "$ROOT/dotfiles"/*/; do
    pkg=$(basename "$dir")
    stow --adopt --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
done