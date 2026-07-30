{ ... }:

{ # --- Basic networking config to allow connection ---

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
}
