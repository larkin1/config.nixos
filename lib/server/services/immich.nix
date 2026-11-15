{ hostname, ... }:

let
  data = "/var/lib/immich";
  mount = "/var/lib/microvms/${hostname}";
in
{
  imports = [ ./postgresql.nix ];

  microvm = {
    volumes = [
      {
        image = "${mount}/immich.img";
        size = 10240;
        mountPoint = data;
        label = "immich";
      }
      {
        image = "${mount}/cache.img";
        size = 4096;
        mountPoint = "/var/cache/immich";
        label = "immich-cache";
      }
    ];
  };

  services.immich = {
    enable = true;

    host = "0.0.0.0";
    port = 2283;

    mediaLocation = data;

    settings = {
      logging = {
        enabled = true;
        level = "warn";
      };
    };
  };
}
