{ config, inputs, ... }:

{
  imports = [ inputs.boo.nixosModules.default ];

  sops.secrets.boo-env = { };

  services.boo = {
    enable = true;
    host = "0.0.0.0";
    port = 3017;
    environmentFile = config.sops.secrets.boo-env.path;
  };
}
