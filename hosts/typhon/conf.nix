{ inputs, lib, config, ... }:

{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/system/server/vms.nix
    inputs.microvm.nixosModules.host

    ../../lib/system/dev/nvim.nix
  ];

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
