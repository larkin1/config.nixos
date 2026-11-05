{ config, lib, hostname, ... }:

let
  vm = config.server.vms.${hostname};
  net = config.server.net;
  gw = "10.0.0.0";
in
{
  imports = [ ./vms.nix ];

  options.server.net = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Route this guest on Typhon's tap. False if VM is not running on Typhon.";
    };
    dnsServers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "9.9.9.9" "1.1.1.1" ];
      description = "10.0.0.0 once typhon runs a DNS resolver.";
    };
  };

  config = lib.mkIf net.enable {
    microvm.interfaces = [{
      type = "tap";
      id = vm.tap;
      inherit (vm) mac;
      tap.vhost = config.microvm.hypervisor == "qemu";
    }];

    networking.useNetworkd = true;
    networking.useDHCP = false;

    systemd.network.networks."10-eth" = {
      matchConfig.MACAddress = vm.mac;
      address = [ "${vm.ip}/32" ];
      routes = [
        { Destination = "${gw}/32"; Scope = "link"; }
        { Destination = "0.0.0.0/0"; Gateway = gw; GatewayOnLink = true; }
      ];
      networkConfig.DNS = net.dnsServers;
    };
  };
}
