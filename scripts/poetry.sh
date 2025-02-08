# check if poetry is installed
if command -v poetry &> /dev/null
then
    echo "Poetry is already installed"
    exit
fi

curl -sSL https://install.python-poetry.org | python3 -
echo "export PATH=\$HOME/.local/bin:\$PATH" >> ~/.zshrc 
