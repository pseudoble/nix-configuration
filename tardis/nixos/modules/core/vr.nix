{ pkgs, ... }:

let
  # 100 Mb/s default bitrate; adjust later if tests demand more.
  defaultBitrate = 100000000;
in
{
  services.wivrn = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    defaultRuntime = true;
    package = pkgs.wivrn.override { cudaSupport = true; };

    # Streaming defaults tuned for Quest 2; revisit after real-world tests.
    config = {
      enable = true;
      json = {
        scale = 1.0;
        bitrate = defaultBitrate;
        encoders = [
          {
            # Start with CPU x264 encoding; revisit NVENC once packaged with support.
            encoder = "x264";
            codec = "h264";
            width = 1.0;
            height = 1.0;
            offset_x = 0.0;
            offset_y = 0.0;
          }
        ];
      };
    };
  };

  environment.sessionVariables = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };
}
