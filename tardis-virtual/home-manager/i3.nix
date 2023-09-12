{ config, lib, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/i3".source = ./i3;
}
