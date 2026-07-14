{ pkgs, hostname, ... }:

{
  imports =
    [
      ./hardware.nix
      ./home.nix

      ../../lib/system/core/locale.nix
      ../../lib/system/core/bootloader.nix
      ../../lib/system/core/base.nix

      ../../lib/system/hardware/nvidia.nix
      ../../lib/system/hardware/disk-optimisations.nix

      ../../lib/system/services/bluetooth.nix
      ../../lib/system/services/pipewire.nix
      ../../lib/system/services/network.nix

      ../../lib/system/desktop/fonts.nix
      ../../lib/system/desktop/desktop.nix

      ../../lib/system/dev/nvim.nix
    ];

  # TEMPORARY UNTIL SPICETIFY BUMPS TO A LATER PNPM VER
  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
  ];

  boot.tmp.useTmpfs = true; # Use RAM for /tmp
}
