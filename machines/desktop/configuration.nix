{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../common/system/base-user.nix
      ../../common/system/bluetooth.nix
      ../../common/system/bootloader.nix
      ../../common/system/disk-optimisations.nix
      ../../common/system/hypr.nix
      ../../common/system/locale.nix
      ../../common/system/network.nix
      ../../common/system/pipewire.nix
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
    neovim
    wget
    git
  ];

  # These feel like they would be common between configs, but i don't know where to put them.
  environment.variables.EDITOR = "nvim";
  hardware.graphics.enable = true;
  security.polkit.enable = true;
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Leave this
  system.stateVersion = "26.05";
}
