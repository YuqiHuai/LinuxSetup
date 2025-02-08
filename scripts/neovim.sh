# check if neovim is installed
if command -v nvim &> /dev/null
then
   echo "Neovim is already installed"
    exit 
fi

curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
rm -rf $HOME/.local/nvim-linux-x86_64
tar -C $HOME/.local -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:$HOME/.local/nvim-linux-x86_64/bin"' >> ~/.zshrc
rm nvim-linux-x86_64.tar.gz