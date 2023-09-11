#!/bin/bash

git clone https://github.com/pseudoble/nix-configuration.git ~/.nixos
cd ~/.nixos

sudo nix-rebuild switch --flake .#nixos
