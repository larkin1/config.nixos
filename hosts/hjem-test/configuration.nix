{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hjem.nix
      # ../../lib/system/base-user.nix
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

  networking.hostName = "hjem-test";

  # networking.firewall = {
  #   extraCommands = ''
  #     iptables -I INPUT -m pkttype --pkt-type multicast -j ACCEPT
  #     iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
  #     iptables -I INPUT -p udp -m udp --match multiport --dports 1990,2021 -j ACCEPT
  #     iptables -I INPUT -p tcp -m tcp --dport 990 -j ACCEPT
  #     iptables -I INPUT -p tcp -m tcp --dport 8883 -j ACCEPT
  #   '';
  # };

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
