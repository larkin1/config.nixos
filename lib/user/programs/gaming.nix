{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # G27
  hardware.new-lg4ff.enable = true;
  boot.blacklistedKernelModules = [ "hid_logitech" ];
  services.udev.packages = [ pkgs.oversteer ];
}
