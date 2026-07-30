{ pkgs, ... }:

{
  services.nordvpn.enable = true;
  environment.systemPackages = with pkgs; [
    nordvpn
  ];
}
