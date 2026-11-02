{ hostname, ... }:

{
  imports = [
    ../../lib/system/core/base.nix
    ../../lib/system/server/immich.nix
    ../../lib/system/server/base.nix
  ];

  # login to the server with `ssh -p 2222 ${username}@localhost`
  # the server may be updated with `microvm -u ${hostname}` then `systemctl restart microvm@${hostname}`
  microvm = {
    vcpu = 2;
    mem = 4096;

    interfaces = [{
      type = "user";
      id = "eth0";
      mac = "02:00:00:01:01:01";
    }];

    forwardPorts = [
      { from = "host"; host.port = 2222; guest.port = 22; }
    ];

    volumes = [
    {
      image = "/var/lib/microvms/${hostname}/data.img";
      size = 10240;
      mountPoint = "/var/lib/data";
    }
    {
      image = "/var/lib/microvms/${hostname}/postgres.img";
      size = 10240;
      mountPoint = "/var/lib/postgresql";
    }
    ];

    shares = [{
      tag = "sops";
      source = "/var/lib/microvms/shared/sops/${hostname}";
      mountPoint = "/var/lib/sops-nix";
      proto = "virtiofs";
    }];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/postgresql 0700 postgres postgres -"
    "z /var/lib/postgresql 0700 postgres postgres -"
  ];

  sops.secrets.test = { };
}
