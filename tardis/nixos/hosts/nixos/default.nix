# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  programs.nix-ld.enable = true;

  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/core/bootloader.nix
      ../../modules/core/bluetooth.nix
      ../../modules/core/network.nix
      ../../modules/core/sound.nix
      ../../modules/core/users.nix
      ../../modules/core/x11.nix
      ../../modules/core/fonts.nix
      ../../modules/core/vr.nix
  ];
  
  # Allow unfree packages
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    # Add these new garbage collection settings
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  security.rtkit.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.gnome.gnome-keyring.enable = false;
  services.printing.enable = false;
  services.envfs.enable = true;
  
  services.avahi = {
    enable = true;        # This enables the Avahi daemon
    nssmdns4 = true;       # This enables mDNS for .local name resolution via NSS
    openFirewall = true;  # This will open UDP port 5353 in your firewall if networking.firewall.enable is true
    publish = {
      enable = true;
      userServices = true;
      workstation = true;
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
  services.flatpak.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.udev = {
    enable = true;

    # Use `packages` to define udev rules declaratively
    packages = [
      # Vial udev rule
      (pkgs.writeTextFile {
        name = "vial-udev-rule";
        text = ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';
        destination = "/etc/udev/rules.d/99-vial.rules";
      })
    ];

    extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
  };


  # Virtualization
  virtualisation.libvirtd.enable = true;

  #programs.fish.enable = true;
  programs.zsh.enable = true;

  boot.kernelParams = [ "amd_pstate=disable" ];

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    gparted
    pcmanfm
    pavucontrol
    bluez
    stow

    qemu
    libvirt
    virt-manager
    qemu_kvm

    mesa
    xorg.xkill
    vulkan-tools
    vulkan-headers
    vulkan-loader
    config.boot.kernelPackages.nvidiaPackages.stable.settings
    
    appimage-run
    home-manager
    powershell

    v4l-utils

    opencomposite

    # brlaser

    libva

    # linuxKernel.packages.linux_6_15.xpadneo
    # #linuxKernel.packages.linux_6_6.v4l2loopback
  ];

  # hardware.xone.enable = true; # Disabled; retry later after xpad-noone is updated for newer kernels.
  hardware.uinput.enable = true;

  programs.dconf.enable = true;

  programs.adb.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for 2 Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
  };

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
