# x11.nix

{ config, pkgs, ... }:

{
  hardware.opengl = {
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

    driSupport = true;
    driSupport32Bit = true;
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
