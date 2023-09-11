{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Charles Josephs";
    userEmail = "cjosephs@gmail.com";
  };
}
