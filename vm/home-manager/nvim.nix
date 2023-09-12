{ config, lib, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/nvim".source = ./nvim;
}
