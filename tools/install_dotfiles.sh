#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ADOPT=0
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

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

backup_conflicts() {
    local pkg="$1"
    local dir="$ROOT/dotfiles/$pkg"
    local source_file
    local rel_path
    local target
    local backup

    while IFS= read -r -d '' source_file; do
        rel_path="${source_file#"$dir"/}"
        target="$HOME/$rel_path"

        if [ -e "$target" ] && [ ! -L "$target" ] && [ -f "$target" ]; then
            backup="$target.$BACKUP_SUFFIX"
            echo "Backing up existing $target to $backup"
            mv "$target" "$backup"
        fi
    done < <(find "$dir" -type f -print0)
}

for dir in "$ROOT/dotfiles"/*/; do
    pkg=$(basename "$dir")
    if [ "$ADOPT" -eq 1 ]; then
        stow --adopt --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    else
        backup_conflicts "$pkg"
        stow --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    fi
done
