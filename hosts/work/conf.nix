{ pkgs, hostname, ... }:

{
  imports =
    [
      ./hardware.nix
      ./home.nix
      ../../lib/system/core/locale.nix
      ../../lib/system/core/bootloader.nix
      ../../lib/system/hardware/nvidia.nix
      ../../lib/system/hardware/disk-optimisations.nix
      ../../lib/system/services/bluetooth.nix
      ../../lib/system/services/pipewire.nix
      ../../lib/system/services/network.nix
      ../../lib/system/desktop/fonts.nix
      ../../lib/system/dev/nvim.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [ # TEMPORARY UNTIL SPICETIFY BUMPS TO A LATER PNPM VER
    "pnpm-10.29.2"
  ];

  networking.hostName = hostname;

  boot.tmp.useTmpfs = true; # Use RAM for /tmp

  nixpkgs.config.allowUnfree = true; # Allows unfree packages

  # System packages
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # These feel like they would be common between configs, but i don't know where to put them.
  hardware.graphics.enable = true;
  security.polkit.enable = true;
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Leave this
  system.stateVersion = "26.05";
}
