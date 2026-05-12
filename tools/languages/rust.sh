#!/usr/bin/env bash
set -euo pipefail

echo "Installing Rust toolchain..."

# dependencies
sudo apt update
sudo apt install -y \
    build-essential \
    curl \
    pkg-config \
    libssl-dev

# install rustup + rust + cargo
if ! command -v rustup >/dev/null 2>&1; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

# load cargo environment
source "$HOME/.cargo/env"

# update toolchain
rustup update

echo "Rust installed"
echo "rustc: $(rustc --version)"
echo "cargo: $(cargo --version)"
