# exit if zsh is already installed
if command -v zsh &> /dev/null
then
    echo "ZSH is already installed"
    exit
fi

apt install zsh # Install ZSH
chsh -s $(which zsh) # Change default shell to ZSH

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

