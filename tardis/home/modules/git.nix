{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Charles Josephs";
      user.email = "cjosephs@gmail.com";
    };
  };
}
