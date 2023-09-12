{ config, lib, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/nushell" = {
    source = ./nushell;
    recursive = true;
  };
}
