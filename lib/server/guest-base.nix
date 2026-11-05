{ hostname, lib, config, ... }:

let
  state = "/var/lib/microvms/${hostname}";
  backup = "/var/backup/${hostname}";
in
{
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
