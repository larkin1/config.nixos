{ pkgs, ... }:

{ # --- Basic pipewire audio setup ---

  # Enable "real-time scheduling support"
  security.rtkit.enable = true;

  # Use Pipewire and add some other support
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-no-bluetooth-sink.conf" ''
        monitor.bluez.properties = {
          bluez5.roles = [ a2dp_source hfp_ag hsp_ag bap_source bap_sink hfp_hf ]
        }
      '')
    ];
  };
}
