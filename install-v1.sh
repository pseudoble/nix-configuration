#!/bin/bash

git clone https://github.com/pseudoble/nix-configuration.git ~/.nixos
cd ~/.nixos/tardis

echo "Installing NixOS Configuration..."
source ./setup-v1.sh $@

