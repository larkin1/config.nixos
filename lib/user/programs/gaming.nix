{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # G27
  hardware.new-lg4ff.enable = true;
  boot.blacklistedKernelModules = [ "hid_logitech" ];
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="hid", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c29b", ATTR{autocenter}="0", ATTR{gain}="65535"
  '';
  services.udev.packages = [ pkgs.oversteer ];
}
