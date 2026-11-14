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
