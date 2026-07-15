{ pkgs, username, ... }:

let
  orca-slicer-wrapped = pkgs.symlinkJoin {
    name = "orca-slicer";
    paths = [ pkgs.orca-slicer ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/orca-slicer \
        --prefix XDG_DATA_DIRS : "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    '';
  };
in
{
  programs.dconf.enable = true;

  hjem.users."${username}" = {
    packages = [
      orca-slicer-wrapped
      pkgs.python3 # Required to install the open source networking module.
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
