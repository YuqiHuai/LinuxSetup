#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ADOPT=0
MODE="symlink"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"
BACKUP_DIR="$HOME/.dotfiles-backup"

usage() {
    cat <<USAGE
Usage: install_dotfiles.sh [--adopt] [--copy]

Options:
  --adopt  Adopt existing target files into this repo before restowing.
  --copy   Copy dotfiles into $HOME instead of creating symlinks.
USAGE
}

for arg in "$@"; do
    case "$arg" in
        --adopt)
            ADOPT=1
            ;;
        --copy)
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

backup_conflicts() {
    local pkg="$1"
    local dir="$ROOT/dotfiles/$pkg"
    local source_file
    local rel_path
    local target
    local backup_dir

    while IFS= read -r -d '' source_file; do
        rel_path="${source_file#"$dir"/}"
        target="$HOME/$rel_path"

        if [ -e "$target" ] && [ ! -L "$target" ] && [ -f "$target" ]; then
            backup_dir="$BACKUP_DIR/$BACKUP_SUFFIX/$(dirname "$rel_path")"
            mkdir -p "$backup_dir"
            echo "Backing up existing $target to $backup_dir/"
            mv "$target" "$backup_dir/"
        fi
    done < <(find "$dir" -type f -print0)
}

copy_dotfiles() {
    local pkg="$1"
    local dir="$ROOT/dotfiles/$pkg"
    local source_file
    local rel_path
    local target

    while IFS= read -r -d '' source_file; do
        rel_path="${source_file#"$dir"/}"
        target="$HOME/$rel_path"
        mkdir -p "$(dirname "$target")"
        if [ -L "$target" ]; then
            rm "$target"
        fi
        cp "$source_file" "$target"
    done < <(find "$dir" -type f -print0)
}

for dir in "$ROOT/dotfiles"/*/; do
    pkg=$(basename "$dir")
    if [ "$MODE" = "copy" ]; then
        backup_conflicts "$pkg"
        copy_dotfiles "$pkg"
    elif [ "$ADOPT" -eq 1 ]; then
        stow --adopt --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    else
        backup_conflicts "$pkg"
        stow --restow -d "$ROOT/dotfiles" -t "$HOME" "$pkg"
    fi
done
