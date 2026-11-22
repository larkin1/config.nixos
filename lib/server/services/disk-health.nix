{ config, ... }:

{
  imports = [ ./alerts.nix ];

  server.alerts.units = [
    "disk-health"
  ];

  systemd.services.disk-health = {
    description = "periodically check disk health";
    path = [ config.boot.zfs.package ];
    script = ''
      status=$(zpool status -x)
      echo "$status"
      echo "$status" | grep -qx 'all pools are healthy'
    '';
    startAt = "*-*-* *:00:00";
    serviceConfig.Type = "oneshot";
  };
}
