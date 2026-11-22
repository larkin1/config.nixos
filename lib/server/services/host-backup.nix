{ config, ... }:

{
  imports = [ ./alerts.nix ];

  server.alerts.units = [
    "restic-backups-typhon-backup"
    "restic-backups-typhon-prune"
  ];

  sops.secrets."restic-r2-env" = { };

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
        set -euo pipefail
        dir=/var/backup
        max_age_min=$((26 * 60))

        missing=()
        stale=()
        jobs=0

        for job in "$dir"/*/*/; do
          [ -d "$job" ] || continue
          jobs=$((jobs + 1))

          if [ "$(basename "$job")" = postgresql ]; then
            marker="$job"all.sql
          else
            marker="$job".backup-stamp
          fi

          if [ ! -e "$marker" ]; then
            missing+=("$marker")
          elif [ -n "$(find "$marker" -mmin +"$max_age_min")" ]; then
            stale+=("$marker")
          fi
        done

        if [ "$jobs" -eq 0 ]; then
          echo "backup check: no job directories under $dir" >&2
          exit 1
        fi

        if [ ''${#missing[@]} -gt 0 ] || [ ''${#stale[@]} -gt 0 ]; then
          echo "backup check failed ($jobs jobs checked)" >&2
          for m in "''${missing[@]}"; do echo "  missing: $m" >&2; done
          for s in "''${stale[@]}";   do echo "  stale:   $s" >&2; done
          exit 1
        fi

        echo "backup check: $jobs jobs fresh"
      '';
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
      checkOpts = [
        "--read-data-subset=5%"
      ];
    };
  };
}
