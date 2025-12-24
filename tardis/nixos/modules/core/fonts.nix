{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    #nerdfonts
    nerd-fonts.monaspace
    nerd-fonts.meslo-lg
  ];
}
