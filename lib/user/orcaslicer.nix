{ pkgs, username, ... }:

{
  programs.dconf.enable = true;

  hjem.users."${username}" = {
    packages = with pkgs; [
      orca-slicer
    ];
  };

  networking.firewall = {
    extraCommands = ''
      iptables -I INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -I INPUT -p udp -m udp --match multiport --dports 1990,2021 -j ACCEPT
      iptables -I INPUT -p tcp -m tcp --dport 990 -j ACCEPT
      iptables -I INPUT -p tcp -m tcp --dport 8883 -j ACCEPT
    '';
  };
}
