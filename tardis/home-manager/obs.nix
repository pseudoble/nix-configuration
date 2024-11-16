{ config, pkgs, ... }:

let
  obs-vertical-canvas = pkgs.callPackage ./pkgs/obs-vertical-canvas {
    wrapQtAppsHook = pkgs.qt6Packages.wrapQtAppsHook;
  };
in{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-freeze-filter
      obs-vertical-canvas
      obs-vintage-filter
    ];
  };
}
