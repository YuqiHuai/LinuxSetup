#!/usr/bin/env bash
set -euo pipefail

if [ -f /.dockerenv ]; then
    echo "Running inside Docker container, skipping Hyper install"
    exit 0
fi

if command -v hyper >/dev/null; then
    echo "Hyper already installed"
    exit 0
fi

ARCH="$(dpkg --print-architecture)"
case "$ARCH" in
    amd64)
        HYPER_ASSET="deb"
        ;;
    arm64)
        HYPER_ASSET="deb_arm64"
        ;;
    *)
        echo "Unsupported architecture for Hyper: $ARCH" >&2
        exit 1
        ;;
esac

echo "Installing Hyper..."

DEB="$(mktemp --suffix=.deb)"
trap 'rm -f "$DEB"' EXIT

curl -fL "https://releases.hyper.is/latest/${HYPER_ASSET}" -o "$DEB"
sudo apt-get install -y "$DEB"

if ! command -v hyper >/dev/null; then
    echo "Hyper install did not create a usable hyper executable" >&2
    exit 1
fi

echo "Hyper installed"
