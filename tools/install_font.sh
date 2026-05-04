#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: install_font.sh <font-script>"
  exit 1
fi

FONT_SCRIPT="$1"

# Load font metadata
source "$FONT_SCRIPT"

FONT_DIR="$HOME/.local/share/fonts"
TMP_ZIP="$(mktemp)"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${VERSION}/${FONT_NAME}.zip"
trap 'rm -f "$TMP_ZIP"' EXIT

echo "Installing ${FONT_NAME} Nerd Font..."

mkdir -p "$FONT_DIR"

# Skip if already installed
if fc-list | grep -qi "$FONT_NAME"; then
  echo "${FONT_NAME} already installed"
  exit 0
fi

echo "Downloading ${FONT_URL}"
curl -fL "$FONT_URL" -o "$TMP_ZIP"

echo "Extracting..."
unzip -q "$TMP_ZIP" -d "$FONT_DIR"

echo "Refreshing font cache..."
fc-cache -fv >/dev/null

echo "${FONT_NAME} installed successfully"
