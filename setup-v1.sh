#!/bin/bash

cd ~/.nixos/tardis-virtual

echo "Running setup with the following arguments: [$@]"
# Check if --generate-config passed
if [[ "$@" == *"--copy-config"* ]]; then
  if [ -f "/etc/nixos/configuration.nix" ]; then
    echo "Copying /etc/nixos/configuration.nix to ./nixos"
    cp /etc/nixos/configuration.nix ./nixos
  else
    echo "No /etc/nixos/configuration.nix found"
    exit 1
  fi
#    sudo nixos-generate-config --root ./nixos
fi


sudo nixos-rebuild switch --flake .#tardis-virtual
home-manager switch --flake .#cjosephs@tardis-virtual

echo "Reopen your terminal to see changes"
