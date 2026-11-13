{ pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];

  boot.extraModprobeConfig = "options nvidia NVreg_TemporaryFilePath=/var/tmp";

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
}
