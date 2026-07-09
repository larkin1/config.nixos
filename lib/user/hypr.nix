{ pkgs, inputs, hostDir, username, ... }:
 
{
  hjem.users."${username}".files = {
    ".config/hypr".source = pkgs.symlinkJoin {
      name = "hypr-config";
      paths = [
        ../../configs/hypr
        (pkgs.writeTextDir "lua/monitors.lua" (builtins.readFile "${hostDir + "/home/monitors.lua"}"))
        (pkgs.writeTextDir "lua/devices.lua" (builtins.readFile "${hostDir + "/home/devices.lua"}"))
      ];
    };

    ".config/wallpapers".source = "${inputs.config-walls}";
  };
}
