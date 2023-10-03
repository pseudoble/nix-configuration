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
      tardis-minimal = {
        description = ''
          My desktop configuration
        '';
        path = ./tardis-minimal;
      }; 
      tardis-virtual = {
        description = ''
          My virtual machine configuration
        '';
        path = ./tardis-virtual;
      };
    };
  };
}
