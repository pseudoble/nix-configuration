{ config, pkgs, ... }:
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        # Directories
        "inode/directory" = [ "pcmanfm.desktop" ];

        # HTML/Web-related files
        "text/html" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/about" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/unknown" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/tel" = [ "vivaldi-stable.desktop" ];

        # Image files
        "image/jpeg" = [ "gthumb.desktop" ];  # Use gThumb for JPEG images
        "image/png" = [ "gthumb.desktop" ];   # Use gThumb for PNG images
        "image/gif" = [ "gthumb.desktop" ];   # Add GIF handling to gThumb

        # JSON files
        "application/json" = [ "code.desktop" ];  # Use VSCode for JSON files

        # Custom type for CQL files
        "text/x-cql" = [ "code.desktop" ];  # Use VSCode for CQL files
        "text/plain" = [ "code.desktop" ];  # This helps catch CQL files that fall back to plain text
        "application/x-cql" = [ "code.desktop" ];  # Additional MIME type mapping

        # Archive files
        "application/zip" = [ "xarchiver.desktop" ];
        "application/x-rar" = [ "xarchiver.desktop" ];
        "application/x-7z-compressed" = [ "xarchiver.desktop" ];

        # Mail-related URIs
        "x-scheme-handler/mailto" = [ "userapp-Evolution-YS2Z91.desktop" ];  # Use Evolution for mailto links

        # JetBrains tools (for specific JetBrains URLs or integration)
        "x-scheme-handler/jetbrains" = [ "jetbrains-toolbox.desktop" ];
        "x-scheme-handler/fleet" = [ "jetbrains-fleet-1237c9f5-f249-4220-91b0-f6a8e2d4a413.desktop" ];

        # Steam-related protocols (using Valve entries)
        "x-scheme-handler/steam" = [ "valve-URI-steamvr.desktop" ];
        "x-scheme-handler/vrmonitor" = [ "valve-vrmonitor.desktop" ];

        # Game launchers (examples based on your desktop files)
        "application/x-ms-dos-executable" = [ "SteamVR.desktop" ];  # Set SteamVR for Windows executable games

        # Proton and Steam Runtime
        "application/vnd.valve.steamruntime" = [ "Proton Hotfix.desktop" ];
      };
    };

    configFile = {
      "mime/packages/cql-files.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
          <mime-type type="application/x-cql">
            <glob pattern="*.cql"/>
            <comment>CQL Source File</comment>
            <sub-class-of type="text/plain"/>
          </mime-type>
        </mime-info>
      '';
    };
  };
}