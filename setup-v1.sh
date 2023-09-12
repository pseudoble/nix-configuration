#!/bin/bash

FLAKE_NAME=tardis-virtual

FLAKE_PATH_BASE=$HOME/.nixos/$FLAKE_NAME
CONFIG_PATH_BASE=$FLAKE_PATH_BASE/nixos
NIXOS_CONFIG_PATH_BASE=/etc/nixos
NIXOS_HARDWARE_CONFIG_PATH=$NIXOS_CONFIG_PATH_BASE/hardware-configuration.nix

cd $FLAKE_PATH_BASE

# Check if --generate-config passed
if [[ "$@" == *"--copy-config"* ]]; then
  if [ -f "$NIXOS_HARDWARE_CONFIG_PATH" ]; then
    echo "Copying $NIXOS_HARDWARE_CONFIG_PATH to $CONFIG_PATH_BASE"
    cp $NIXOS_HARDWARE_CONFIG_PATH $CONFIG_PATH_BASE
  else
    echo "No $NIXOS_HARDWARE_CONFIG_PATH found"
    exit 1
  fi
#    sudo nixos-generate-config --root ./nixos
fi


sudo nixos-rebuild switch --flake .#$FLAKE_NAME
home-manager switch --flake .#cjosephs@$FLAKE_NAME

echo "Reopen your terminal to see changes"
