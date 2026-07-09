{ pkgs, inputs, hostDir, username, ... }:
 
{
  hjem.users."${username}".files = {
    ".config/hypr".source = pkgs.runCommand "hypr-config" {} ''
      mkdir -p $out
      cp -r ${../../configs/hypr}/. $out/
      chmod -R u+w $out
      cp    ${hostDir + "/home/monitors.lua"}  $out/lua/monitors.lua
      cp    ${hostDir + "/home/devices.lua"}   $out/lua/devices.lua
    '';

    ".config/wallpapers".source = "${inputs.config-walls}";
  };
}
