{ username, hostname, lib, ... }:

let
  state = "/var/lib/microvms/${hostname}";
  backup = "/var/backup/${hostname}";
in
{
  microvm = {
    hypervisor = lib.mkDefault "qemu";
    socket = "${state}/${hostname}.sock";

    shares = [
      {
        tag = "sops";
        source = "/var/lib/microvms/shared/sops/${hostname}";
        mountPoint = "/var/lib/sops-nix";
        proto = "virtiofs";
        readOnly = true;
      }
      {
        tag = "backup";
        source = backup;
        mountPoint = "/var/backup";
        proto = "virtiofs";
      }
    ];
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl/mea3a7cPnEYRbW446cLjBfC/zJZL6lLQrNMP4omN larkin@laptop" ];
  };

  security.sudo.wheelNeedsPassword = lib.mkDefault false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
