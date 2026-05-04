#!/usr/bin/env bash
set -euo pipefail

if ! command -v zsh >/dev/null; then
    echo "Installing zsh..."
    sudo apt-get install -y zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    export RUNZSH=no
    export CHSH=no
    export KEEP_ZSHRC=yes
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# Skip shell change inside containers
if [ -f /.dockerenv ]; then
    echo "Running inside container, skipping chsh"
    exit 0
fi

# Change the default shell without prompting for the user's password.
ZSH_PATH="$(command -v zsh)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
    if sudo -n true 2>/dev/null; then
        sudo chsh -s "$ZSH_PATH" "$USER"
    else
        echo "Skipping default shell change because sudo requires a password."
        echo "Run this later if you want zsh as your login shell:"
        echo "  sudo chsh -s $ZSH_PATH $USER"
    fi
fi
