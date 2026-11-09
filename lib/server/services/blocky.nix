{ config, lib, ... }:

let
  serverIP = "192.168.0.236";
in
{
  # This is meant to run on typhon, not a guest vm. It is both an ad blocker, and a custom DNS resolver for split horizon dns
  imports = [ ../sites.nix ];

  boot.kernel.sysctl."net.ipv4.ip_nonlocal_bind" = 1;
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  services.blocky = {
    enable = true;
    settings = {

      ports.dns = [
        "${serverIP}:53"
        "10.0.0.0:53"
      ];
      ports.http = "127.0.0.1:4000";

      customDNS = {
        customTTL = "1m"; # change this to 1h once config is sorted out.
        mapping = lib.genAttrs (
          builtins.attrNames config.server.sites
          ++ builtins.attrNames (lib.filterAttrs (_name: fwd: fwd.dns) config.server.forwards)
        ) (_name: serverIP);
      };

      upstreams.groups.default = [
        "https://one.one.one.one/dns-query"
      ];
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };

      blocking = {
        loading = {
          refreshPeriod = "1h";
          strategy = "fast";
        };

        denylists = {
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://small.oisd.nl"
          ];
          custom = [ "https://raw.githubusercontent.com/larkin1/blocky-list/master/block" ];
        };
        allowlists = {
          custom = [ "https://raw.githubusercontent.com/larkin1/blocky-list/master/allow" ];
        };

        clientGroupsBlock = {
          default = [
            "ads"
            "custom"
          ];
        };
      };
    };
  };
}
