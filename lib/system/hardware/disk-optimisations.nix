{ config, pkgs, ... }:

{ # --- optimise some things about the disk ---

  # Nix optimisations:
  # Limit number of configs that can be in the bootloader
  # boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.grub.configurationLimit = 3;
  # Collect garbage weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # Enable auto-optimisation of the store
  nix.settings.auto-optimise-store = true;
}
