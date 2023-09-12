#!/bin/bash

git clone https://github.com/pseudoble/nix-configuration.git ~/.nixos
cd ~/.nixos

echo "Installing NixOS Configuration with the following arguments: [$@]..."
source ./setup-v1.sh $@

