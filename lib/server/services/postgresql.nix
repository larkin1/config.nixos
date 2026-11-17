{ ... }:

{
  # contains common settings for services that use postgresql
  services.postgresqlBackup = {
    enable = true;
    startAt = "*-*-* 01:00:00"; # vms backup to shared dir at 0100; the host backs those dirs up to r2 at 0115
    location = "/var/backup/postgresql";
    compression = "none";
  };

  systemd.services.postgresqlBackup.unitConfig.RequiresMountsFor = "/var/backup";
}
