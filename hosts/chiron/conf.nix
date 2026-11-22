{ hostname, ... }:

# let
#   vm = config.server.vms.${hostname};
# in
{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/server/access.nix
    ../../lib/server/guest-base.nix
    ../../lib/server/guest-net.nix

    ../../lib/server/services/immich.nix
    ../../lib/server/services/ntfy-server.nix
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
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/postgresql 0700 postgres postgres -"
    "z /var/lib/postgresql 0700 postgres postgres -"
  ];
}
