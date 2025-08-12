# x11.nix

{ config, pkgs, ... }:

{
  security.polkit.enable = true;

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };
  
  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

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
