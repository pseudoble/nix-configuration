# users.nix

{ config, pkgs, ... }:

{
  users.users.cjosephs = {
    isNormalUser = true;
    description = "Charles Josephs";
    extraGroups = [
       "networkmanager" 
       "wheel" 
       "audio" 
       "pulse-access" 
       "libvirtd" 
       "uucp" 
       "network" 
       "fuse" 
       "dialout" 
       "tty" 
       "input" 
       "video" 
       "render"
       "adbusers"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # Minecraft server user and group
  users.groups.minecraft = {};
  
  users.users.minecraft = {
    isSystemUser = true;       # Marks this user as a system user
    group = "minecraft";       # Assigns the user to the "minecraft" group
    home = "/var/minecraft";   # Sets the home directory for the user
    createHome = true;         # Ensures the home directory is created on rebuild
    shell = pkgs.bash;  
    packages = with pkgs; [ jdk21_headless ];
  };

  nix.settings.trusted-users = [ "root" "cjosephs" ];

  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];

}
