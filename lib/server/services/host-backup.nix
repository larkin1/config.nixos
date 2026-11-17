{ config, ... }:

{
  sops.secrets."restic-r2-env" = { };

  # TODO: set up ntfy and add error reporting.

  services.restic.backups = {
    "typhon-backup" = {
      environmentFile = config.sops.secrets.restic-r2-env.path;
      paths = [ "/var/backup" ];
      initialize = true;
      timerConfig = {
        OnCalendar = "01:15";
        Persistent = "true";
      };

      backupPrepareCommand = ''
        dir=/var/backup
        threshold_minutes=$((26*60))
        if find "$dir" -type f -mmin "+$threshold_minutes" -print -quit | grep -q .; then
          exit 0
        else
          exit 1
        fi
      '';

      checkOpts = [
        "--read-data-subset=5%"
      ];
    };

    "typhon-prune" = {
      environmentFile = config.sops.secrets.restic-r2-env.path;
      paths = [ ];
      timerConfig = {
        OnCalendar = "Fri 03:00:00";
        Persistent = "true";
      };
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
      ];
    };
  };
}
