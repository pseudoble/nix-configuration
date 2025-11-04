{ pkgs, ... }:

{
  # DISABLED - Sunshine game streaming
  # # Ensure Sunshine binary is available in the user environment.
  # home.packages = [ pkgs.sunshine ];

  # # Launch Sunshine automatically when the user enters a graphical session.
  # systemd.user.services.sunshine = {
  #   Unit = {
  #     Description = "Sunshine game streaming service (Moonlight host)";
  #     After = [ "graphical-session.target" ];
  #     Wants = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.sunshine}/bin/sunshine";
  #     Restart = "on-failure";
  #     RestartSec = "5s";
  #     Environment = [
  #       "DISPLAY=:0"
  #       "XAUTHORITY=%h/.Xauthority"
  #     ];
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };
}
