# x11.nix

{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        rofi
      ];
    };

    layout = "us";
    xkbVariant = "";
  };
}
