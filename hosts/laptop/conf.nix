{ pkgs, inputs, lib, config, ... }:

{
  imports = [
    ./hardware.nix
    ./home.nix

    ../../lib/system/core/locale.nix
    ../../lib/system/core/bootloader.nix
    ../../lib/system/core/base.nix

    ../../lib/system/hardware/disk-optimisations.nix
    ../../lib/system/hardware/power_management.nix
    ../../lib/system/hardware/power_triggers.nix
    ../../lib/system/hardware/printers.nix
    ../../lib/system/hardware/logi.nix

    ../../lib/system/services/bluetooth.nix
    ../../lib/system/services/pipewire.nix
    ../../lib/system/services/network.nix
    ../../lib/system/services/nordvpn.nix

    ../../lib/system/desktop/fonts.nix
    ../../lib/system/desktop/desktop.nix

    ../../lib/system/dev/nvim.nix

    ../../lib/system/security/global.nix

    ../../lib/system/server/vms.nix  # TEMP server testing
    inputs.microvm.nixosModules.host # TEMP server testing
  ];

  boot.tmp.useTmpfs = true; # Use RAM for /tmp

  boot.loader.timeout = 5;

  swapDevices = [{
    device = "/swapfile";
    size = 8192;
  }];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  # --- TEMP Typhon Dev ---

  # TEMP until all hosts are created for vms
  microvm.vms.pegasus.flake = inputs.self;
  microvm.vms.pegasus.restartIfChanged = true;
  microvm.autostart = [ "pegasus" ];

  # microvm = { # when all hosts are created for vms
  #   vms = lib.mapAttrs (name: _: {
  #     flake = inputs.self;
  #     restartIfChanged = true;
  #   }) config.server.vms;
  #
  #   autostart = lib.attrNames config.server.vms;
  # };

  systemd.tmpfiles.rules = lib.concatMap (vm: [
    "d /var/lib/microvms/shared/sops/${vm} 0700 microvm microvm -"
    "d /var/backup/${vm} 0700 microvm microvm -"
  ]) (lib.attrNames config.server.vms);
}
