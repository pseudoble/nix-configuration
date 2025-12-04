{ config, pkgs, lib, ... }:

let
  xrizerDir = "${config.xdg.dataHome}/xrizer";
  wivrnPkg = pkgs.wivrn.override { cudaSupport = true; };
in
{
  # Use WiVRn as the primary OpenXR runtime with host-local runtime metadata.
  home.file."${config.xdg.configHome}/openxr/1/active_runtime.json" = {
    text = ''
      {
        "file_format_version": "1.0.0",
        "runtime": {
          "name": "WiVRn",
          "library_path": "${xrizerDir}/libopenxr_wivrn.so",
          "MND_libmonado_path": "${xrizerDir}/libmonado_wivrn.so"
        }
      }
    '';
    force = true;
  };

  home.file.".local/share/xrizer/libopenxr_wivrn.so".source =
    "${wivrnPkg}/lib/wivrn/libopenxr_wivrn.so";

  home.file.".local/share/xrizer/libmonado_wivrn.so".source =
    "${wivrnPkg}/lib/wivrn/libmonado_wivrn.so";

  # Force OpenVR apps (including Proton titles) through OpenComposite -> OpenXR chain.
  home.file.".local/share/xrizer/bin/linux64/vrclient.so".source =
    "${pkgs.xrizer}/lib/xrizer/bin/linux64/vrclient.so";

  home.file.".config/openvr/openvrpaths.vrpath" = {
    text = ''
      {
        "config" : [
          "${config.xdg.dataHome}/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" : [
          "${config.xdg.dataHome}/Steam/logs"
        ],
        "runtime" : [
          "${config.xdg.dataHome}/xrizer"
        ],
        "version" : 1
      }
    '';
    # Keep SteamVR from overwriting the runtime path.
    force = true;
  };
}
