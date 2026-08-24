{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "armourcpq" ];
    ensureUsers = [
      { name = "armourcpq"; ensureDBOwnership = true; }
    ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all              peer
      host  all all 127.0.0.1/32 scram-sha-256
      host  all all ::1/128      scram-sha-256
    '';
  };
}
