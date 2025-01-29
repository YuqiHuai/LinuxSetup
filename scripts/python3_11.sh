# check if python3.11 is installed
if command -v python3.11 &> /dev/null
then
    echo "Python 3.11 is already installed"
    exit
fi

add-apt-repository ppa:deadsnakes/ppa -y
apt update
apt install python3.11 -y