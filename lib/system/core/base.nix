{ hostname, ... }:

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

  sops.defaultSopsFile = "${../../../secrets}/${hostname}.yaml";
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = false;

  system.stateVersion = "26.05";
}
