apt-get update

# Install python3 if not installed
if ! [ -x "$(command -v pip)" ]; then
  apt-get install python3-pip -y
fi

# Install ansible if not installed
if ! [ -x "$(command -v ansible)" ]; then
  pip install ansible
fi
