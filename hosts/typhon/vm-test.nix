{ lib, ... }:

# Only applies to `nixos-rebuild build-vm --flake .#typhon`.
# The real typhon system is unaffected.
{
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 6;
      memorySize = 12288;  # MiB: typhon plus all three guests
      diskSize = 61440;    # MiB: guest volumes, including pegasus's 40 GiB store overlay
      qemu.options = [ "-cpu host" ];  # pass virtualisation extensions through for nested KVM

      forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; }   # ssh -p 2222 larkin@localhost
        { from = "host"; host.port = 8443; guest.port = 443; }  # Caddy
      ];

      # Your PC's sops key, so typhon's secrets decrypt inside the test VM.
      sharedDirectories.sops = {
        source = "/var/lib/sops-nix";
        target = "/var/lib/sops-nix";
      };
    };

    # build-vm gives typhon QEMU's user-mode network on eth0, not the real NIC.
    server.net.externalInterface = lib.mkForce "eth0";

    # Staging certs: untrusted, but no risk of hitting Let's Encrypt rate limits.
    security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  };
}
