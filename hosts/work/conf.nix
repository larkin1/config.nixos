{ ... }:

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

  nixpkgs.config.permittedInsecurePackages = [
  # TEMPORARY UNTIL VESKTOP BUMPS TO A LATER ELECTRON VER
    "electron-40.10.5"
  ];

  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  boot.tmp.useTmpfs = true; # Use RAM for /tmp
}
