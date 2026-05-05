#!/usr/bin/env bash
set -euo pipefail

MINICONDA_DIR="$HOME/miniconda3"

if [ -x "$MINICONDA_DIR/bin/conda" ]; then
    echo "Miniconda already installed"
    exit 0
fi

if [ -d "$MINICONDA_DIR" ]; then
    backup="$MINICONDA_DIR.incomplete.$(date +%Y%m%d%H%M%S)"
    echo "Moving incomplete Miniconda install to $backup"
    mv "$MINICONDA_DIR" "$backup"
fi

ARCH="$(uname -m)"
case "$ARCH" in
    x86_64)
        MINICONDA_ARCH="x86_64"
        ;;
    aarch64|arm64)
        MINICONDA_ARCH="aarch64"
        ;;
    *)
        echo "Unsupported architecture for Miniconda: $ARCH" >&2
        exit 1
        ;;
esac

INSTALLER="$(mktemp --suffix=.sh)"
trap 'rm -f "$INSTALLER"' EXIT

wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${MINICONDA_ARCH}.sh" -O "$INSTALLER"

bash "$INSTALLER" -b -p "$MINICONDA_DIR"

eval "$("$MINICONDA_DIR/bin/conda" shell.bash hook)"
conda init bash zsh
