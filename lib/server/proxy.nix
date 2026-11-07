{ config, lib, ... }:

let
  vms = config.server.vms;
  sites = config.server.sites;
in
{
  imports = [ ./vms.nix ./sites.nix ];

  config = {
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

    services.caddy = {
      enable = true;
      virtualHosts = lib.mapAttrs (host: site: {
        useACMEHost = "sprk.foo";
        extraConfig = "reverse_proxy ${vms.${site.vm}.ip}:${toString site.port}";
      }) sites;
    };

    networking.firewall.interfaces.${config.server.net.externalInterface}.allowedTCPPorts = [ 80 443 ];
  };
}
