{ config, ... }:

{
  imports = [ ./alerts.nix ];

  server.alerts.units = [
    "ddclient"
  ];

  sops.secrets.cf-ddns-token = { };

  services.ddclient = {
    enable = true;
    interval = "5min";
    protocol = "cloudflare";
    passwordFile = config.sops.secrets.cf-ddns-token.path;
    domains = [
      "sprk.foo"
      "*.sprk.foo"
    ];
    zone = "sprk.foo";
  };
}
