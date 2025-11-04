{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
