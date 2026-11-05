{ inputs, lib, config, ... }:

{
  imports = [
    ./hardware.nix
    ../../lib/system/core/base.nix
    ../../lib/system/core/locale.nix
    ../../lib/server/vms.nix
    ../../lib/server/access.nix
    ../../lib/server/net-host.nix
    inputs.microvm.nixosModules.host

    ../../lib/server/proxy.nix

    ../../lib/system/dev/nvim.nix

    ./vm-test.nix
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
    host.useNotifySockets = true;
    vms = lib.mapAttrs (name: _: {
      flake = inputs.self;
      restartIfChanged = true;
    }) config.server.vms;

    autostart = lib.attrNames config.server.vms;
  };

  server.net.externalInterface = "eth0"; # update once deployed

  systemd.tmpfiles.rules = [ "d /var/lib/microvm-keys 0700 root root -" ]
    ++ lib.concatMap (vm: [
      "d /var/lib/microvm-keys/${vm} 0700 root root -"
      "d /var/backup/${vm} 0700 microvm kvm -"
    ]) (lib.attrNames config.server.vms);
}
