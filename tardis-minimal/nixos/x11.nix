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

  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

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
