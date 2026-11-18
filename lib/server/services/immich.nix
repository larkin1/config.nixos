{ hostname, config, ... }:

let
  data = "/var/lib/immich";
  mount = "/var/lib/microvms/${hostname}";
  url = "photos.sprk.foo";
in
{
  imports = [
    ./postgresql.nix
    ../sites.nix
  ];

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
    port = config.server.sites.${url}.port;

    mediaLocation = data;

    settings = {
      logging = {
        enabled = true;
        level = "warn";
      };
    };
  };
}
