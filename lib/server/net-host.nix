{ config, lib, ... }:

let
  net = config.server.net;
  vms = lib.attrValues config.server.vms;
  gw = "10.0.0.0";
  forwardPorts = lib.concatLists (
    lib.mapAttrsToList (
      _name: fwd:
      lib.concatMap (
        port:
        map (proto: {
          sourcePort = port;
          inherit proto;
          destination = "${config.server.vms.${fwd.vm}.ip}:${toString port}";
        }) fwd.protos
      ) fwd.ports
    ) config.server.forwards
  );
in
{
  imports = [
    ./vms.nix
    ./sites.nix
  ];

  options.server.net.externalInterface = lib.mkOption {
    type = lib.types.str;
    example = "eno1";
    description = "interface that microvm traffic is routed thru";
  };

  config = {
    networking = {
      useNetworkd = true;
      useDHCP = false;

      nat = {
        enable = true;
        internalInterfaces = map (vm: vm.tap) vms;
        inherit forwardPorts;
        inherit (net) externalInterface;
      };

      nftables.enable = true;
      firewall.filterForward = true;
    };

    systemd.network.networks = {
      "10-wan" = {
        matchConfig.Name = net.externalInterface;
        networkConfig.DHCP = "yes";
        networkConfig.IPv6PrivacyExtensions = "no";
      };
    }
    // lib.listToAttrs (
      map (vm: {
        name = "30-${vm.tap}";
        value = {
          matchConfig.Name = vm.tap;
          address = [ "${gw}/32" ];
          routes = [
            {
              Destination = "${vm.ip}/32";
              Scope = "link";
            }
          ];
          linkConfig.RequiredForOnline = false;
          networkConfig = {
            ConfigureWithoutCarrier = true;
            IPv4Forwarding = true;
          };
        };
      }) vms
    );

  };
}
