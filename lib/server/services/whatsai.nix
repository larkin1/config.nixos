{
  inputs,
  hostname,
  config,
  ...
}:

let
  lanBlock = {
    IPAddressDeny = [
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
      "169.254.0.0/16"
      "fc00::/7"
      "fe80::/10"
    ];
    IPAddressAllow = [
      "localhost"
      "10.0.0.0/32"
    ];
  };
in
{
  imports = [ inputs.whatsai.nixosModules.default ];

  sops.secrets.whatsai-env = { };

  systemd.services.whatsai.serviceConfig = lanBlock;
  systemd.services.whatsai-aria2.serviceConfig = lanBlock;

  services.whatsai = {
    enable = true;
    environmentFile = config.sops.secrets.whatsai-env.path;
    environment = {
      TZ = "Australia/Sydney";
      WHATSAI_PUBLIC_URL = "https://what.sprk.foo";
    };
  };

  microvm = {
    volumes = [
      {
        image = "/var/lib/microvms/${hostname}/whatsai.img";
        size = 51200; # 50 GiB
        mountPoint = "/var/lib/whatsai";
        label = "whatsai";
      }
    ];
  };
}
