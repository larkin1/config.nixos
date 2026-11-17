{
  config,
  hostname,
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
    ./guest-backup.nix
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

  server.backup.vaultwarden = {
    user = "vaultwarden";
    group = "vaultwarden";
    inPath = "/var/lib/vaultwarden";
    extraArgs = [
      "--exclude=lost+found"
      "--exclude=icon_cache/"
      "--exclude=tmp/"
    ];
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
