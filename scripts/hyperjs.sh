sudo update-alternatives --install /usr/bin/x-terminal-emulator \
  x-terminal-emulator $(which hyper) 50
sudo update-alternatives --config x-terminal-emulator
