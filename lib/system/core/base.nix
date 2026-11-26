{ pkgs, hostname, ... }:

{
  # Things that are included on every host by default
  networking.hostName = hostname;

  hardware.enableRedistributableFirmware = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  nix.package = pkgs.lixPackageSets.stable.lix;

  sops = {
    defaultSopsFile = "${../../../secrets}/${hostname}.yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = false;
  };

  system.stateVersion = "26.05";
}
