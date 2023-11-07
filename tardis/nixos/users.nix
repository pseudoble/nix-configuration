# users.nix

{ config, pkgs, ... }:

{
  users.users.cjosephs = {
    isNormalUser = true;
    description = "Charles Josephs";
    extraGroups = [ "networkmanager" "wheel" "audio" "pulse-access" "libvirtd" "uucp" "network" "fuse"];
    # shell = pkgs.fish;
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  nix.settings.trusted-users = [ "root" "cjosephs" ];

  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];

}

