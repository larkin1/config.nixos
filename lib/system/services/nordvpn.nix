{ pkgs, username, ... }:

{
  services.nordvpn.enable = true;
  environment.systemPackages = with pkgs; [ nordvpn ];

  networking.firewall.checkReversePath = false;

  users.groups.nordvpn.members = [ username ];
}
