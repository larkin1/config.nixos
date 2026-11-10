{ ... }:

{
  # --- Basic networking config to allow connection ---

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
  };
}
