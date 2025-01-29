# check if neovim is installed
if command -v nvim &> /dev/null
then
   echo "Neovim is already installed"
    exit 
fi

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc