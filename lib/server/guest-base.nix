{ hostname, lib, config, ... }:

let
  state = "/var/lib/microvms/${hostname}";
  backup = "/var/backup/${hostname}";
in
{
  imports = [ ../system/core/locale.nix ];

  services.openssh.hostKeys = [
    {
      bits = 4096;
      path = "/var/lib/data/ssh-hostkeys/ssh_host_rsa_key";
      type = "rsa";
    }
    {
      path = "/var/lib/data/ssh-hostkeys/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];

  microvm = {
    vsock.cid = config.server.vms.${hostname}.index;
    hypervisor = lib.mkDefault "cloud-hypervisor";
    socket = "${state}/${hostname}.sock";

    shares = [
      {
        tag = "sops";
        source = "/var/lib/microvm-keys/${hostname}";
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
}
