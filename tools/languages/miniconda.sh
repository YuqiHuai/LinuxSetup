#!/usr/bin/env bash
set -euo pipefail

if [ -d "$HOME/miniconda3" ]; then
    echo "Miniconda already installed"
    exit 0
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

INSTALLER="$(mktemp)"
trap 'rm -f "$INSTALLER"' EXIT

wget "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${MINICONDA_ARCH}.sh" -O "$INSTALLER"

bash "$INSTALLER" -b -p "$HOME/miniconda3"

eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
conda init bash zsh
