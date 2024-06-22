# bootloader.nix

{ config, pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
  };

  boot.kernelModules = [ "fuse" "v4l2loopback" ];
  
  boot.extraModulePackages = [ 
    pkgs.linuxPackages.v4l2loopback 
  ];


  boot.initrd.kernelModules = [ "amdgpu" ];
  # security.fsck.auto = false;

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
}
