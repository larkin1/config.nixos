{
  pkgs,
  config,
  lib,
  ...
}:

{
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
    };
  };
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  services.thermald.enable = true;
}
