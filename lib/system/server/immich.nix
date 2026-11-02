{ hostname, ... }:

let
  data = "/var/lib/immich";
  mount = "/var/lib/microvms/immich";
  port = 2283;
in
{
  microvm = {
    volumes = [
    {
      image = "${mount}/immich.img";
      size = 10240;
      mountPoint = data;
    }
    {
      image = "${mount}/cache.img";
      size = 4096;
      mountPoint = "/var/cache/immich";
    }
    ];
    forwardPorts = [
      { from = "host"; host.port = port; guest.port = port; }
    ];
  };

  services.postgresqlBackup = {
    enable = true;
    startAt = "*-*-* 03:15:00";
    location = "/var/backup/${hostname}/postgresql";
  };

  systemd.services.postgresqlBackup.unitConfig.RequiresMountsFor = "/var/backup";

  services.immich = {
    enable = true;

    host = "0.0.0.0";
    port = port;
    openFirewall = true;

    mediaLocation = data;

    settings = {
      logging = {
        enabled = true;
        level = "warn";
      };
    };
  };
}
