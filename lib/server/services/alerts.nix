{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.server.alerts;
in
{
  options.server.alerts.units = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "systemd services that send an ntfy alert when they fail.";
  };

  config = {
    sops.secrets.ntfy-auth = { };

    systemd.services = {
      "notify-failure@" = {
        description = "ntfy alert for failed unit %i";
        serviceConfig = {
          Type = "oneshot";
          LoadCredential = "auth:${config.sops.secrets.ntfy-auth.path}";
        };
        scriptArgs = "%i";
        path = [ pkgs.curl ];
        script = ''
          curl -fsS --retry 3 -H @"$CREDENTIALS_DIRECTORY/auth" \
            -H "Title: $1 failed on ${config.networking.hostName}" -H "Priority: high" -H "Tags: rotating_light" \
            --data-binary "$(journalctl -u "$1" -n 15 --no-pager -o cat)" \
            https://alerts.sprk.foo/alerts
        '';
      };
    }
    // lib.genAttrs cfg.units (_: {
      unitConfig.OnFailure = [ "notify-failure@%n.service" ];
    });
  };
}
