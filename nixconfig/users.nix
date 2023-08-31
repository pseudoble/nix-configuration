# users.nix

{ config, pkgs, ... }:

{
  users.users.cjosephs = {
    isNormalUser = true;
    description = "Charles Josephs";
    extraGroups = [ "networkmanager" "wheel" "audio" "pulse-access" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };
}

