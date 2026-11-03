{ hostname, ... }:

{ # Things that are included on every host by default
  networking.hostName = hostname;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  sops.defaultSopsFile = "${../../../secrets}/${hostname}.yaml";
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = false;

  system.stateVersion = "26.05";
}
