{ ... }:

{ # --- Bluetooth support ---

  # enable it and make sure it turns on when the computer does
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    # allow JBL Partybox to connect because it rejects this role and kills everything for some reason idk ahhhhhhhhhhhhhhhhhhhhhhhhhhhhh
    settings.General.DisabledProfiles = "a2dp-sink";
  };
}
