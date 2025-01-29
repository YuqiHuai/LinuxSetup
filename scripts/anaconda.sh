# exit if conda is already installed
if command -v conda &> /dev/null
then
    echo "Anaconda is already installed"
    exit
fi

wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
bash Anaconda3-2024.10-1-Linux-x86_64.sh -b
source ~/anaconda3/bin/activate
conda init --all
