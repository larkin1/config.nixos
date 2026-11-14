{ hostname, config, ... }:

{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/server/access.nix
    ../../lib/server/guest-base.nix
    ../../lib/server/guest-net.nix

    ../../lib/system/dev/git.nix
    ../../lib/system/dev/nvim.nix
  ];

  microvm = {
    vcpu = 2;
    mem = 4096;

    volumes = [
      {
        # generic data dir
        image = "/var/lib/microvms/${hostname}/data.img";
        size = 10240;
        mountPoint = "/var/lib/data";
        label = "data";
      }
      {
        # postgres dir, so dbs aren't killed between vm restarts
        image = "/var/lib/microvms/${hostname}/postgres.img";
        size = 10240;
        mountPoint = "/var/lib/postgresql";
        label = "postgres";
      }
      {
        # make nix store writeable from in the vm
        image = "/var/lib/microvms/${hostname}/nix-store-overlay.img";
        mountPoint = config.microvm.writableStoreOverlay;
        size = 40960;
        label = "nix-store";
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/postgresql 0700 postgres postgres -"
    "z /var/lib/postgresql 0700 postgres postgres -"
  ];

  # allow rebuilding from inside the machine
  system.switch.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  microvm.writableStoreOverlay = "/nix/.rwstore";
}
