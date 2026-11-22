{
  inputs,
  lib,
  config,
  ...
}:

{
  imports = [
    # hardware
    ./hardware.nix
    ./disko.nix
    inputs.disko.nixosModules.disko

    # system-critical
    ../../lib/system/core/base.nix
    ../../lib/system/core/locale.nix
    ../../lib/server/vms.nix
    ../../lib/server/access.nix
    ../../lib/server/net-host.nix
    inputs.microvm.nixosModules.host

    # services
    ../../lib/server/proxy.nix
    ../../lib/server/services/ddns.nix
    ../../lib/server/services/blocky.nix
    ../../lib/server/services/host-backup.nix

    # superfluous
    ../../lib/system/dev/nvim.nix

    # for testing
    ./vm-test.nix
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      {
        devices = [ "nodev" ];
        path = "/boot";
      }
      {
        devices = [ "nodev" ];
        path = "/boot-fallback";
      }
    ];
  };

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.kernelParams = [ "zfs.zfs_arc_max=17179869184" ];
  networking.hostId = "49389043";

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  zramSwap.enable = true;

  nix.settings.trusted-users = [ "@wheel" ];

  microvm = {
    host.useNotifySockets = true;
    vms = lib.mapAttrs (name: _: {
      flake = inputs.self;
      restartIfChanged = true;
    }) config.server.vms;

    autostart = lib.attrNames config.server.vms;
  };

  server.net.externalInterface = "eno3np0";

  systemd.tmpfiles.rules = [
    "d /var/lib/microvm-keys 0700 root root -"
  ]
  ++ lib.concatMap (vm: [
    "d /var/lib/microvm-keys/${vm} 0700 root root -"
    "d /var/backup/${vm} 0755 microvm kvm -"
  ]) (lib.attrNames config.server.vms);
}
