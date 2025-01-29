# check if zoxide is installed
if ! command -v zoxide &> /dev/null
then
    # install zoxide
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc