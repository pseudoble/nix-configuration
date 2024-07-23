# sound.nix

{
  # sound = {
  #   enable = true;
  #   mediaKeys.enable = true;
  # };

  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      default-server = unix:/run/user/1000/pulse/native
    '';
    support32Bit = true;
  };
}
