# check if neovim is installed
if command -v nvim &> /dev/null
then
   echo "Neovim is already installed"
    exit 
fi

curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64//bin"' >> ~/.zshrc