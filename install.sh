#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DESKTOP=0
ADOPT_DOTFILES=0

usage() {
  cat <<USAGE
Usage: ./install.sh [--desktop] [--adopt-dotfiles]

Options:
  --desktop         Also run optional local workstation app installers from tools/desktop.
  --adopt-dotfiles  Adopt existing dotfiles into this repo before restowing.
  -h, --help        Show this help message.
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --desktop)
      INSTALL_DESKTOP=1
      ;;
    --adopt-dotfiles)
      ADOPT_DOTFILES=1
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

run_scripts() {
  local label="$1"
  local dir="$2"
  local skip="${3:-}"

  echo
  echo "Installing $label..."

  if [ ! -d "$dir" ]; then
    return
  fi

  shopt -s nullglob
  local scripts=("$dir"/*.sh)
  shopt -u nullglob

  for script in "${scripts[@]}"; do
    if [ -n "$skip" ] && [ "$(basename "$script")" = "$skip" ]; then
      continue
    fi

    echo "Running $(basename "$script")"
    bash "$script"
  done
}

echo "================================"
echo "Linux Setup Bootstrap Starting"
echo "================================"

# ------------------------------------------------
# Base packages
# ------------------------------------------------
echo
echo "Installing base packages..."
bash "$ROOT/tools/core/packages.sh"

# ------------------------------------------------
# Personal bin scripts
# ------------------------------------------------
echo
echo "Installing personal bin scripts..."
bash "$ROOT/tools/install_bin.sh"

# ------------------------------------------------
# System tools
# ------------------------------------------------
run_scripts "system tools" "$ROOT/tools/system"

# ------------------------------------------------
# Shell tools
# ------------------------------------------------
echo
echo "Installing shell tools..."

# Ensure zsh installs first
if [ -f "$ROOT/tools/shell/zsh.sh" ]; then
  echo "Running zsh.sh"
  bash "$ROOT/tools/shell/zsh.sh"
fi

run_scripts "remaining shell tools" "$ROOT/tools/shell" "zsh.sh"

# ------------------------------------------------
# Languages
# ------------------------------------------------
echo
echo "Installing language tools..."

# Ensure Python dependencies are available before Python-based installers.
if [ -f "$ROOT/tools/languages/python.sh" ]; then
  echo "Running python.sh"
  bash "$ROOT/tools/languages/python.sh"
fi

run_scripts "remaining language tools" "$ROOT/tools/languages" "python.sh"

# ------------------------------------------------
# Editors
# ------------------------------------------------
run_scripts "editors" "$ROOT/tools/editors"

# ------------------------------------------------
# Fonts
# ------------------------------------------------
echo
echo "Installing fonts..."
if [ -d "$ROOT/tools/fonts" ]; then
  for font in "$ROOT/tools/fonts/"*.sh; do
    echo "Installing font $(basename "$font")"
    bash "$ROOT/tools/install_font.sh" "$font"
  done
fi

# ------------------------------------------------
# Desktop apps
# ------------------------------------------------
if [ "$INSTALL_DESKTOP" -eq 1 ]; then
  run_scripts "desktop apps" "$ROOT/tools/desktop"
else
  echo
  echo "Skipping desktop apps. Run ./install.sh --desktop to include tools/desktop."
fi

# ------------------------------------------------
# Dotfiles
# ------------------------------------------------
echo
echo "Installing dotfiles..."
if [ "${ADOPT_DOTFILES:-0}" -eq 1 ]; then
  bash "$ROOT/tools/install_dotfiles.sh" --adopt
else
  bash "$ROOT/tools/install_dotfiles.sh"
fi

# ------------------------------------------------
# Finished
# ------------------------------------------------
echo
echo "================================"
echo "Bootstrap complete!"
echo "================================"
