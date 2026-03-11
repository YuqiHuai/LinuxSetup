#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "================================"
echo "Linux Setup Bootstrap Starting"
echo "================================"

# ------------------------------------------------
# Base packages
# ------------------------------------------------
echo
echo "Installing base packages..."
bash "$ROOT/packages.sh"

# ------------------------------------------------
# System tools
# ------------------------------------------------
echo
echo "Installing system tools..."
if [ -d "$ROOT/tools/system" ]; then
  for script in "$ROOT/tools/system/"*.sh; do
    echo "Running $(basename "$script")"
    bash "$script"
  done
fi

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

for script in "$ROOT/tools/shell/"*.sh; do
  if [[ "$script" != "$ROOT/tools/shell/zsh.sh" ]]; then
    echo "Running $(basename "$script")"
    bash "$script"
  fi
done

# ------------------------------------------------
# Languages
# ------------------------------------------------
echo
echo "Installing language tools..."
if [ -d "$ROOT/tools/languages" ]; then
  for script in "$ROOT/tools/languages/"*.sh; do
    echo "Running $(basename "$script")"
    bash "$script"
  done
fi

# ------------------------------------------------
# Editors
# ------------------------------------------------
echo
echo "Installing editors..."
if [ -d "$ROOT/tools/editors" ]; then
  for script in "$ROOT/tools/editors/"*.sh; do
    echo "Running $(basename "$script")"
    bash "$script"
  done
fi

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
# Dotfiles
# ------------------------------------------------
echo
echo "Installing dotfiles..."
bash "$ROOT/tools/install_dotfiles.sh"

# ------------------------------------------------
# Finished
# ------------------------------------------------
echo
echo "================================"
echo "Bootstrap complete!"
echo "================================"