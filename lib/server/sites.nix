{ lib, config, ... }:

{
  imports = [ ./vms.nix ];

  options.server.sites = lib.mkOption {
    description = "hostnames, and the vm each is proxied to.";
    default = { };
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        vm = lib.mkOption { type = lib.types.str; };
        port = lib.mkOption { type = lib.types.port; };
      };
    });
  };

  config = {
    server.sites = {
      "photos.sprk.foo" = { vm = "pegasus"; port = 2283; };
    };

    assertions = lib.mapAttrsToList (host: site: {
      assertion = config.server.vms ? ${site.vm};
      message = "server.sites.${host}: no VM called '${site.vm}' in server.vms.";
    }) config.server.sites;
  };
}
