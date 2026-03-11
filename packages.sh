#!/usr/bin/env bash
set -euo pipefail

echo "Installing base system packages..."

sudo apt update

sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  unzip \
  ca-certificates \
  software-properties-common \
  gnupg \
  stow \
  zsh \
  tmux \
  ripgrep \
  fd-find \
  fzf \
  bat \
  tree \
  htop \
  jq \
  xclip \
  fontconfig \
  nodejs \
  npm \
  luarocks

echo "System packages installed"
