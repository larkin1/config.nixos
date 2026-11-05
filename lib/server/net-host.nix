{ config, lib, ...}:

let
  net = config.server.net;
  vms = lib.attrValues config.server.vms;
  gw = "10.0.0.0";
in
{
  imports = [ ./vms.nix ];

  options.server.net.externalInterface = lib.mkOption {
    type = lib.types.str;
    example = "eno1";
    description = "interface that microvm traffic is routed thru";
  };

  config = {
    networking.useNetworkd = true;
    networking.useDHCP = false;

    systemd.network.networks = {
      "10-wan" = {
        matchConfig.Name = net.externalInterface;
        networkConfig.DHCP = "yes";
      };
    } // lib.listToAttrs (map (vm: {
      name = "30-${vm.tap}";
      value = {
        matchConfig.Name = vm.tap;
        address = [ "${gw}/32" ];
        routes = [{ Destination = "${vm.ip}/32"; Scope = "link"; }];
        linkConfig.RequiredForOnline = false;
        networkConfig = {
          ConfigureWithoutCarrier = true;
          IPv4Forwarding = true;
        };
      };
    }) vms);

    networking.nat = {
      enable = true;
      externalInterface = net.externalInterface;
      internalInterfaces = map (vm: vm.tap) vms;
    };

    networking.nftables.enable = true;
    networking.firewall.filterForward = true;
  };
}
