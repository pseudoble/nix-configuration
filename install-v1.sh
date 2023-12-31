#!/bin/bash

# Set branch to install 
BRANCH="main"

# Construct zip URL with branch
ZIP_URL="https://github.com/pseudoble/nix-configuration/archive/$BRANCH.zip"

# Create tmp folder 
TMP_DIR=/tmp/nixos-install
mkdir -p $TMP_DIR

# Download ZIP  
curl -L $ZIP_URL -o $TMP_DIR/nix-config.zip

# Unzip 
unzip $TMP_DIR/nix-config.zip -d $TMP_DIR 

# Copy files to ~/.nixos
cp -r $TMP_DIR/nix-configuration-$BRANCH ~/.nixos

cd ~/.nixos

# Run setup
echo "Installing NixOS configuration from branch $BRANCH..."  
source ./setup-v1.sh $@

