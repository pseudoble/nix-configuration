#!/bin/bash

cd ~/.nixos/tardis 

# Check if --generate-config passed
if [ "$1" == "--generate-config" ]; then
    sudo nixos-generate-config --root ./nixos
fi

sudo nixos-rebuild switch --flake .#nixos
home-manager switch --flake .#cjosephs@nixos

echo "Repoen your terminal to see changes"

