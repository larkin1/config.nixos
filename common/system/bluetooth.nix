{ config, pkgs, ... }:

{ # --- Bluetooth support ---

  # enable it and make sure it turns on when the computer does
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
