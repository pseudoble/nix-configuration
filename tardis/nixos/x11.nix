# x11.nix

{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };
  
  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

    desktopManager = {
      xterm.enable = false;
    };


    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        rofi
      ];
    };

    xkb.layout = "us";
    xkb.variant = "";
  };
}
