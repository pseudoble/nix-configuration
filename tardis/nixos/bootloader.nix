# bootloader.nix

{
  boot.loader.grub = {
    enable = true;
    device = "/dev/nvme0n1";
    useOSProber = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "fuse" ];
}
