#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE="symlink"

usage() {
    cat <<USAGE
Usage: install_bin.sh [--mode=symlink|--mode=copy]

Options:
  --mode=symlink  Link scripts into ~/.local/bin. This is the default.
  --mode=copy     Copy scripts into ~/.local/bin so the repo can be removed.
USAGE
}

for arg in "$@"; do
    case "$arg" in
        --mode=symlink)
            MODE="symlink"
            ;;
        --mode=copy)
            MODE="copy"
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

mkdir -p "$HOME/.local/bin"

shopt -s nullglob
for file in "$ROOT/bin/"*; do
    name=$(basename "$file")
    if [ "$MODE" = "copy" ]; then
        install -m 755 "$file" "$HOME/.local/bin/$name"
    else
        ln -sf "$file" "$HOME/.local/bin/$name"
    fi
done
shopt -u nullglob

echo "Personal scripts installed"
