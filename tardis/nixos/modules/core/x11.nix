# x11.nix

{ config, pkgs, ... }:

{
  security.polkit.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    # Power management for laptops and desktops.
    powerManagement.enable = true;
    # Fine-grained power management can be unstable.
    powerManagement.finegrained = false;

    # Use the proprietary driver
    open = false;

    # Specify the NVIDIA driver package.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Disable GSP firmware (known to cause system crashes/freezes)
    # See: https://wiki.archlinux.org/title/NVIDIA#GSP_firmware
    # This addresses Sunshine NVENC restart freeze issues
    nvidiaSettings = true;
    forceFullCompositionPipeline = false;
  };

  # Disable NVIDIA GSP firmware to fix system freezes
  boot.kernelParams = [ "nvidia.NVreg_EnableGpuFirmware=0" ];

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
