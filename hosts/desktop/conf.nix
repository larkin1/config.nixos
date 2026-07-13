{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../lib/system/base-user.nix
      ../../lib/system/bluetooth.nix
      ../../lib/system/bootloader.nix
      ../../lib/system/disk-optimisations.nix
      ../../lib/system/hypr.nix
      ../../lib/system/locale.nix
      ../../lib/system/network.nix
      ../../lib/system/pipewire.nix
      ../../lib/system/nvim.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [ # TEMPORARY UNTIL SPICETIFY BUMPS TO A LATER PNPM VER
    "pnpm-10.29.2"
  ];

  networking.hostName = "desktop";

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
