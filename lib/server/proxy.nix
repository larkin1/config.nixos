{ config, lib, ... }:

let
  vms = config.server.vms;
  sites = config.server.sites;
in
{
  imports = [
    ./vms.nix
    ./sites.nix
    ./services/alerts.nix
  ];

  config = {
    server.alerts.units = [
      "acme-order-renew-sprk.foo"
      "acme-sprk.foo"
    ];

    sops.secrets.cloudflare-acme = { };

    security.acme = {
      acceptTerms = true;
      defaults.email = "88820972+larkin1@users.noreply.github.com";
      certs."sprk.foo" = {
        domain = "*.sprk.foo";
        extraDomainNames = [ "sprk.foo" ];
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        environmentFile = config.sops.secrets.cloudflare-acme.path;
        group = "caddy";
      };
    };

    sops.secrets.caddy-auth = { };

    systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.secrets.caddy-auth.path;

    services.caddy = {
      enable = true;
      virtualHosts = lib.mapAttrs (_: site: {
        useACMEHost = "sprk.foo";
        extraConfig = ''
          ${lib.optionalString site.auth ''
            basic_auth {
              larkin {$BASIC_AUTH_HASH}
            }
          ''}
          reverse_proxy ${vms.${site.vm}.ip}:${toString site.port}
        '';
      }) sites;
    };

    networking.firewall.interfaces.${config.server.net.externalInterface}.allowedTCPPorts = [
      80
      443
    ];
  };
}
