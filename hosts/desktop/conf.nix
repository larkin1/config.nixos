{ ... }:

{
  imports =
    [
      ./hardware.nix
      ./home.nix
      ../../lib/system/core/locale.nix
      ../../lib/system/core/bootloader.nix
      ../../lib/system/core/base.nix

      ../../lib/system/hardware/disk-optimisations.nix
      ../../lib/system/hardware/nvidia.nix

      ../../lib/system/services/bluetooth.nix
      ../../lib/system/services/network.nix
      ../../lib/system/services/pipewire.nix

      ../../lib/system/desktop/fonts.nix
      ../../lib/system/desktop/desktop.nix

      ../../lib/system/dev/nvim.nix
    ];

  boot.tmp.useTmpfs = true; # Use RAM for /tmp
}
