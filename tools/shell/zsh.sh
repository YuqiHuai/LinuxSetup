#!/usr/bin/env bash
set -euo pipefail

if ! command -v zsh >/dev/null; then
    echo "Installing zsh..."
    sudo apt-get install -y zsh
fi

# Skip shell change inside containers
if [ -f /.dockerenv ]; then
    echo "Running inside container, skipping chsh"
    exit 0
fi

# change default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi