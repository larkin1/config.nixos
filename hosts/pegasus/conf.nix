{ hostname, config, ... }:

let
  vm = config.server.vms.${hostname};
in
{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/server/access.nix
    ../../lib/server/guest-base.nix
    ../../lib/server/guest-net.nix

    ../../lib/system/dev/git.nix
    ../../lib/system/dev/nvim.nix

    ../../lib/server/services/immich.nix
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
      { # make nix store writeable from in the vm
        image = "/var/lib/microvms/${hostname}/nix-store-overlay.img";
        mountPoint = config.microvm.writableStoreOverlay;
        size = 40960;
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/postgresql 0700 postgres postgres -"
    "z /var/lib/postgresql 0700 postgres postgres -"
  ];

  # allow rebuilding from inside the machine
  system.switch.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  microvm.writableStoreOverlay = "/nix/.rwstore";

  # TEMP for laptop dev
  microvm.hypervisor = "qemu";
  server.net.enable = false;
  microvm.interfaces = [{
    type = "user";
    id = vm.tap;
    inherit (vm) mac;
  }];
  microvm.forwardPorts = [
    { from = "host"; host.port = 2200+vm.index ; guest.port = 22; } # allow me to ssh into the vm
    { from = "host"; host.port = 2283; guest.port = 2283; } # allow me to test immich on localhost
  ];
}
