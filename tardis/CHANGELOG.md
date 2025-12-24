# Changelog

All notable changes to this NixOS configuration will be documented in this file.

## 2025-12-24

### Added
- Enabled envfs to provide FHS-compatible paths for legacy shebangs (e.g., /bin/bash)

### Changed
- nixos/configuration.nix: Enabled services.envfs
- home-manager/zsh.nix: Updated osup to use the flake target
- nixos/configuration.nix: Disabled xpadneo
- nixos/configuration.nix: Enabled xone for Xbox controllers
- nixos/configuration.nix: Temporarily disabled xone due to xpad-noone build failure on Linux 6.18; retry later

## 2025-11-04

### Added
- **tree** package installed via home-manager (v2.2.1)
- **python310** with jsonpickle package installed via home-manager
  - Makes `/home/cjosephs/dev/motive/elm-python-transpiler/scala3transpiler` flake unnecessary for these dependencies
  - jq was already present, verified working

### Changed
- home-manager/home.nix: Added tree and python310 with jsonpickle to package list

### Disabled
- **Sunshine** game streaming service completely disabled
  - Stopped and disabled systemd service
  - Commented out sunshine.nix import in home-manager/home.nix
  - Commented out sunshine package in home-manager/home.nix
  - Commented out Sunshine firewall rules in nixos/network.nix (TCP/UDP ports 47984-48010)
- Commented out all configuration in home-manager/sunshine.nix with "DISABLED" marker
