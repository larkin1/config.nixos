{ config, pkgs, ... }:

{ # --- Basic pipewire audio setup ---

  # Enable "real-time scheduling support"
  security.rtkit.enable = true;

  # Use Pipewire and add some other support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
