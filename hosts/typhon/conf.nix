{ inputs, lib, config, ... }:

{
  imports = [
    ./hardware.nix
    ../../lib/system/core/base.nix
    ../../lib/system/core/locale.nix
    ../../lib/server/vms.nix
    ../../lib/server/access.nix
    inputs.microvm.nixosModules.host

    ../../lib/system/dev/nvim.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  microvm = {
    vms = lib.mapAttrs (name: _: {
      flake = inputs.self;
      restartIfChanged = true;
    }) config.server.vms;

    autostart = lib.attrNames config.server.vms;
  };

  systemd.tmpfiles.rules = lib.concatMap (vm: [
    "d /var/lib/microvms/shared/sops/${vm} 0700 microvm microvm -"
    "d /var/backup/${vm} 0700 microvm microvm -"
  ]) (lib.attrNames config.server.vms);
}
