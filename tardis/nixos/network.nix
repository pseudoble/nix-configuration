# network.nix

{
  networking.hostName = "nixos";  # Define your hostname

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 7777 4455 25565 ];
    allowedUDPPorts = [ 9944 7777 25565 47998 47999 ];
    # allowedTCPPortRanges = [
    #   # Sunshine web UI and streaming control ports (Moonlight/GameStream)
    #   { from = 47984; to = 47990; }
    #   { from = 48000; to = 48010; }
    # ];
    # allowedUDPPortRanges = [
    #   # Sunshine video/audio streaming ports (Moonlight/GameStream)
    #   { from = 47984; to = 47986; }
    #   { from = 48000; to = 48010; }
    # ];
  };
}
