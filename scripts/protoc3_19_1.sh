# download protoc 3.19.1

DOWNLOAD_URL=https://github.com/protocolbuffers/protobuf/releases/download/v3.19.1/protoc-3.19.1-linux-x86_64.zip

# download protoc
wget -O protoc.zip $DOWNLOAD_URL

# unzip
unzip protoc.zip -d $HOME/.local

# remove zip
rm protoc.zip