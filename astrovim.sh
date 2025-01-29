# exit if nvim config exists
if [ -d ~/.config/nvim ]
then
    echo "Neovim config already exists"
    exit
fi

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git