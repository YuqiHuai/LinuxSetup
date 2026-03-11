#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "Installing base packages..."
bash "$ROOT/packages.sh"

echo "Installing system tools..."
for script in "$ROOT/tools/system/"*.sh; do
    bash "$script"
done

echo "Installing shell tools..."
for script in "$ROOT/tools/shell/"*.sh; do
    bash "$script"
done

echo "Installing languages..."
for script in "$ROOT/tools/languages/"*.sh; do
    bash "$script"
done

echo "Installing editors..."
for script in "$ROOT/tools/editors/"*.sh; do
    bash "$script"
done

echo "Installing fonts..."
for font in "$ROOT/tools/fonts/"*.sh; do
    bash "$ROOT/tools/install_font.sh" "$font"
done

echo "Installing dotfiles..."
bash "$ROOT/tools/install_dotfiles.sh"

bash tools/install_bin.sh

echo "Bootstrap complete 🚀"