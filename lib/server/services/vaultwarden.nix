{
  config,
  hostname,
  ...
}:

let
  domain = "vault.sprk.foo";
  site = config.server.sites."${domain}";
  # vm = config.server.vms."${site.vm}";
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

      # ROCKET_ADDRESS = vm.ip;
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = site.port;
      ROCKET_LOG = "critical";
    };
  };
}
