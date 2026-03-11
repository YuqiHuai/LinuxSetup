#!/usr/bin/env bash
set -euo pipefail

if command -v lazygit >/dev/null; then
  echo "lazygit already installed"
  exit 0
fi

echo "Installing lazygit..."

LAZYGIT_VERSION=$(curl -s \
https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
| grep tag_name | cut -d '"' -f 4)

curl -Lo lazygit.tar.gz \
https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz

tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

rm lazygit lazygit.tar.gz