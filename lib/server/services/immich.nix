{ hostname, ... }:

let
  data = "/var/lib/immich";
  mount = "/var/lib/microvms/${hostname}";
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
  };

  services.postgresqlBackup = {
    enable = true;
    startAt = "*-*-* 03:15:00";
    location = "/var/backup/postgresql";
  };

  systemd.services.postgresqlBackup.unitConfig.RequiresMountsFor = "/var/backup";

  services.immich = {
    enable = true;

    host = "0.0.0.0";
    port = 2283;

    mediaLocation = data;

    settings = {
      logging = {
        enabled = true;
        level = "warn";
      };
    };
  };
}
