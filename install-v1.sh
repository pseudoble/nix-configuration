#!/bin/bash

git clone https://github.com/pseudoble/nix-configuration.git ~/.nixos
cd ~/.nixos/tardis

sudo nixos-rebuild switch --flake .#nixos
