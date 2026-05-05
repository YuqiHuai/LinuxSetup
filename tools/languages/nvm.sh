#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="v0.40.4"
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [ -d "$NVM_DIR" ] && [ ! -s "$NVM_DIR/nvm.sh" ]; then
    backup="$NVM_DIR.incomplete.$(date +%Y%m%d%H%M%S)"
    echo "Moving incomplete nvm install to $backup"
    mv "$NVM_DIR" "$backup"
fi

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    echo "Installing nvm..."
    export PROFILE=/dev/null
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
else
    echo "nvm already installed"
fi

source "$NVM_DIR/nvm.sh"

echo "Installing latest Node.js LTS..."
nvm install --lts
nvm alias default 'lts/*'
nvm use default

echo "nvm setup complete"
