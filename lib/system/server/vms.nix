{ lib, config, ... }:

let
  table = {
    pegasus =  { index = 11; };
    chiron =   { index = 12; };
    tartarus = { index = 13; };
  };
  vmType = { config, name, ... }: {
    options = {
      index = lib.mkOption {
        type = lib.types.ints.between 1 254;
        description = "Used to create IP, MAC, and tap name. Do not modify once deployed.";
      };
      tap = lib.mkOption {
        type = lib.types.str; readOnly = true;
        default = "vm${toString config.index}";
      };
      ip = lib.mkOption {
        type = lib.types.str; readOnly = true;
        default = "10.0.0.${toString config.index}";
      };
      mac = lib.mkOption {
        type = lib.types.str; readOnly = true;
        default = "02:00:00:00:00:${lib.fixedWidthString 2 "0" (lib.toLower (lib.toHexString config.index))}";
      };
    };
  };
in
{
  options.server.vms = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule vmType);
    default = table;
  };

  config.assertions = [{
    assertion =
      let idx = map (v: v.index) (lib.attrValues config.server.vms);
      in builtins.length idx == builtins.length (lib.unique idx);
    message = "server.vms: Duplicate index occurred. Please use a unique index.";
  }];
}
