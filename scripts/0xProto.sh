#!/bin/bash

# Set the fonts directory
FONT_DIR="$HOME/.fonts"

# Check if the fonts directory exists, if not, create it
if [ ! -d "$FONT_DIR" ]; then
  mkdir -p "$FONT_DIR"
  echo "Created directory: $FONT_DIR"
else
  echo "Directory $FONT_DIR already exists"
fi

# Download the font archive
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/0xProto.zip"
ZIP_FILE="$HOME/0xProto.zip"

echo "Downloading font from $FONT_URL..."
wget -q --show-progress "$FONT_URL" -O "$ZIP_FILE"

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "Download complete. Unzipping..."
  # Unzip the font archive to the .fonts directory
  unzip -q "$ZIP_FILE" -d "$FONT_DIR"
  
  # Remove the zip file after extraction
  rm -f "$ZIP_FILE"
  echo "Fonts have been extracted to $FONT_DIR"
else
  echo "Error downloading the font file."
fi
