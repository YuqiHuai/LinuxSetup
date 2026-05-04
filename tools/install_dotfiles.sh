#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ADOPT=0

usage() {
    cat <<USAGE
Usage: install_dotfiles.sh [--adopt]

Options:
  --adopt  Adopt existing target files into this repo before restowing.
USAGE
}

for arg in "$@"; do
    case "$arg" in
        --adopt)
            ADOPT=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $arg" >&2
            usage >&2
            exit 1
            ;;
    esac
done

for dir in "$ROOT/dotfiles"/*/; do
    pkg=$(basename "$dir")
    if [ "$ADOPT" -eq 1 ]; then
        stow --adopt --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    else
        stow --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    fi
done
