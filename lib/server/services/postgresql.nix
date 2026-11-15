{ ... }:

{
  # contains common settings for services that use postgresql
  systemd.tmpfiles.settings = {
    "backup"."/var/backup/postgresql".d = {
      mode = "0700";
      user = "root";
      group = "root";
    };
  };

  services.postgresqlBackup = {
    enable = true;
    startAt = "*-*-* 01:00:00"; # vms backup to shared dir at 0100; the host backs those dirs up to r2 at 0115
    location = "/var/backup/postgresql";
  };

  systemd.services.postgresqlBackup.unitConfig.RequiresMountsFor = "/var/backup";
}
