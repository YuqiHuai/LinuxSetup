#!/usr/bin/env bash
set -euo pipefail

# Skip if already installed
if command -v docker >/dev/null; then
    echo "Docker already installed"
    exit 0
fi

# Skip inside containers
if [ -f /.dockerenv ]; then
    echo "Running inside Docker container — skipping Docker install"
    exit 0
fi

echo "Installing Docker..."
echo "===================="

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update

# Install Docker
sudo apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

echo
echo "Configuring Docker..."
echo "====================="

# Add user to docker group
sudo groupadd -f docker
sudo usermod -aG docker "$USER"

echo
echo "Docker installed successfully."
echo
echo "You must log out and log back in for docker group changes to take effect."
