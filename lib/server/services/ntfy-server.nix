{ config, ... }:

let
  url = "alerts.sprk.foo";
in
{
  imports = [
    ../sites.nix
  ];

  sops.secrets."ntfy-env" = { };

  services.ntfy-sh = {
    enable = true;
    environmentFile = config.sops.secrets."ntfy-env".path; # defines auth users and auth tokens
    settings = {
      base-url = "https://${url}";
      listen-http = "0.0.0.0:${toString config.server.sites.${url}.port}";
      auth-default-access = "deny-all";
      enable-signup = false;
    };
  };
}
