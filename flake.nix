{
  description = "My NixOS configs";

  outputs = inputs: {
    templates = {
      tardis = {
        description = ''
          My desktop configuration
        '';
        path = ./tardis;
      };
    };
  };
}
