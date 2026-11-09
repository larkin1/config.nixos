{ lib, config, ... }:

{
  imports = [ ./vms.nix ];

  options.server = {
    sites = lib.mkOption {
      description = "hostnames, and the vm each is proxied to.";
      default = { };
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            vm = lib.mkOption { type = lib.types.str; };
            port = lib.mkOption { type = lib.types.port; };
          };
        }
      );
    };

    forwards = lib.mkOption {
      description = "hostnames that should be forwarded to vms.";
      default = { };
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            vm = lib.mkOption { type = lib.types.str; };
            ports = lib.mkOption { type = lib.types.nonEmptyListOf lib.types.port; };
            protos = lib.mkOption {
              type = lib.types.nonEmptyListOf (
                lib.types.enum [
                  "tcp"
                  "udp"
                ]
              );
            };
            dns = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "should this site be added to LAN DNS resolution?";
            };
          };
        }
      );
    };
  };

  config = {
    server = {
      sites = {
        "photos.sprk.foo" = {
          vm = "chiron";
          port = 2283;
        };
      };

      forwards = {
        "t.sprk.foo" = {
          vm = "pegasus";
          ports = [ 7777 ];
          protos = [
            "tcp"
            "udp"
          ];
        };
      };
    };

    assertions =
      lib.mapAttrsToList (host: site: {
        assertion = config.server.vms ? ${site.vm};
        message = "server.sites.${host}: no VM called '${site.vm}' in server.vms.";
      }) config.server.sites
      ++ lib.mapAttrsToList (host: fwd: {
        assertion = config.server.vms ? ${fwd.vm};
        message = "server.forwards.${host}: no VM called '${fwd.vm}' in server.vms.";
      }) config.server.forwards;
  };
}
