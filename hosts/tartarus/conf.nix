{ hostname, ... }:

# let
#   vm = config.server.vms.${hostname};
# in
{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/system/server/base.nix
    ../../lib/system/server/guest-net.nix
  ];

  microvm = {
    vcpu = 2;
    mem = 4096;

    volumes = [
      { # generic data dir
        image = "/var/lib/microvms/${hostname}/data.img";
        size = 10240;
        mountPoint = "/var/lib/data";
      }
      { # postgres dir, so dbs aren't killed between vm restarts
        image = "/var/lib/microvms/${hostname}/postgres.img";
        size = 10240;
        mountPoint = "/var/lib/postgresql";
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/postgresql 0700 postgres postgres -"
    "z /var/lib/postgresql 0700 postgres postgres -"
  ];

  # # TEMP for laptop dev
  # server.net.enable = false;
  # microvm.interfaces = [{
  #   type = "user";
  #   id = vm.tap;
  #   inherit (vm) mac;
  # }];
  # microvm.forwardPorts = [
  #   { from = "host"; host.port = 2200+vm.index ; guest.port = 22; } # allow me to ssh into the vm
  #   { from = "host"; host.port = 2283; guest.port = 2283; } # allow me to test immich on localhost
  # ];
}
