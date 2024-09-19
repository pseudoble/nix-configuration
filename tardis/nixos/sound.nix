# sound.nix
{
  # Disable PulseAudio
  hardware.pulseaudio.enable = false;

  # Enable PipeWire
  services.pipewire = {
    enable = true;
    pulse.enable = true;  # Enable PulseAudio emulation
    alsa.enable = true;   # Enable ALSA for compatibility
    jack.enable = true;   # Optional: Enable JACK if needed for advanced audio setups
  };

  # Optional: Enable real-time priority for PipeWire processes
  security.rtkit.enable = true;
}
