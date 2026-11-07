{ lib, config, ... }:

let
  host = "typhon";
  sshAddr = "ssh.sprk.foo";
in
{ # This file is to be imported by hosts that will access the server via ssh.
  imports = [ ./vms.nix ];
  programs.ssh = {
    extraConfig = lib.concatLines ([''
    Host ${host}
      HostName ${sshAddr}
  ''] ++ lib.mapAttrsToList (name: values: ''
    Host ${name}
      HostName ${values.ip}
      ProxyJump ${host}
  '') config.server.vms);
  };
}
