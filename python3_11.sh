# check if python3.11 is installed
if command -v python3.11 &> /dev/null
then
    echo "Python 3.11 is already installed"
    exit
fi

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.11 -y