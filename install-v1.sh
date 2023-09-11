#!/bin/bash

git clone https://github.com/pseudoble/nix-configuration.git ~/.nixos
cd ~/.nixos/tardis

# Check if --generate-config passed
if [ "$1" == "--generate-config" ]; then
    sudo nixos-generate-config --root ./nixos
fi

sudo nixos-rebuild switch --flake .#nixos
