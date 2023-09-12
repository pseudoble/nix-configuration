#!/bin/bash

cd ~/.nixos/tardis-virtual

# Check if --generate-config passed
if [ "$1" == "--copy-config" ]; then
#    sudo nixos-generate-config --root ./nixos
    cp /etc/nixos/hardware-configuration.nix ./nixos
fi


sudo nixos-rebuild switch --flake .#tardis-virtual
home-manager switch --flake .#cjosephs@tardis-virtual

echo "Reopen your terminal to see changes"
