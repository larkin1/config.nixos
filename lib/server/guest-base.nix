{ hostname, lib, ... }:

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
}
