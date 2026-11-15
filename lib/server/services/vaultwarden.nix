{
  config,
  hostname,
  pkgs,
  ...
}:

let
  domain = "vault.sprk.foo";
  site = config.server.sites."${domain}";
  data = "/var/lib/vaultwarden";
in
{
  imports = [
    ../sites.nix
    ../vms.nix
    ./postgresql.nix
  ];

  microvm = {
    volumes = [
      {
        image = "/var/lib/microvms/${hostname}/vaultwarden.img";
        size = 10240;
        mountPoint = data;
        label = "vaultwarden";
      }
    ];
  };

  systemd.services."vaultwarden-backup" = {
    serviceConfig = {
      Type = "oneshot";
      User = "vaultwarden";
      path = [ pkgs.rsync ];
      script = ''
        rsync -a --delete --exclude=lost+found --exclude=icon_cache/ --exclude=tmp/ \
          /var/lib/vaultwarden/ /var/backup/vaultwarden/
      '';
      startAt = "*-*-* 01:00:00";
    };
  };

  systemd.tmpfiles.settings = {
    "vaultwarden-backup"."/var/backup/vaultwarden".d = {
      mode = "0700";
      user = "vaultwarden";
      group = "vaultwarden";
    };
  };

  sops.secrets.vaultwarden-env = {
    restartUnits = [ "vaultwarden.service" ];
  };

  services.vaultwarden = {
    enable = true;

    dbBackend = "postgresql";

    configurePostgres = true;
    domain = domain;

    environmentFile = config.sops.secrets.vaultwarden-env.path;
    config = {
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = site.port;
      ROCKET_LOG = "critical";
    };
  };
}
