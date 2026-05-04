#!/usr/bin/env bash
set -euo pipefail

# prevent interactive prompts (tzdata, locales, etc.)
export DEBIAN_FRONTEND=noninteractive

# default timezone for non-interactive installs
export TZ=Etc/UTC

echo "Updating apt repositories..."
sudo apt-get update -y

echo "Installing base packages..."
sudo apt-get install -y \
    build-essential \
    curl \
    git \
    wget \
    unzip \
    ca-certificates \
    fontconfig \
    gnupg \
    lsb-release \
    stow

echo "Cleaning apt cache..."
sudo apt-get autoremove -y
sudo apt-get clean
