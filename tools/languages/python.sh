#!/usr/bin/env bash

if command -v python3.12 >/dev/null; then
    echo "Python 3.12 already installed"
    exit 0
fi

sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update

sudo apt install -y python3.12 python3.12-venv python3.12-dev