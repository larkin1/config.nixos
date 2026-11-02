{ username, hostname, lib, ... }:

let
  data = "/var/lib/microvms";
in
{
  microvm = {
    hypervisor = lib.mkDefault "qemu";
    socket = "${data}/${hostname}/${hostname}.sock";

    shares = [{
      tag = "backup";
      source = "${data}/shared/backup";
      mountPoint = "/var/backup";
      proto = "virtiofs";
    }];
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl/mea3a7cPnEYRbW446cLjBfC/zJZL6lLQrNMP4omN larkin@laptop" ];
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    PermitRootLogin = "no";
  };
}
