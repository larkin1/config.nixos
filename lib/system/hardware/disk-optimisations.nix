{ ... }:

{
  # --- optimise some things about the disk ---
  # Nix optimisations:
  # Limit number of configs that can be in the bootloader
  boot.loader.limine.maxGenerations = 3;
  # Enable auto-optimisation of the store
  nix.settings.auto-optimise-store = true;
}
