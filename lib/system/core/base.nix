{ pkgs, hostname, ... }:

{ # Things that are included on every machine by default

  networking.hostName = hostname;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  system.stateVersion = "26.05";
}
