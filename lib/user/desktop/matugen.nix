{
  pkgs,
  lib,
  config,
  username,
  inputs,
  ...
}:

let
  cfg = config.custom.theming;
  matugen = inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default;
  matugenDir = ".config/matugen"; # We don't use global paths, as hjem doesn't support them. instead if we need a global path, we prepend /home/${username}/

  wallScript = pkgs.writeShellApplication {
    name = "setwall";
    runtimeInputs = [
      matugen
      config.programs.hyprland.package
      pkgs.procps
    ];
    text = builtins.readFile ../../../configs/walls/wall.sh;
  };
in
{
  options.custom.theming = {
    wallpaperName = lib.mkOption {
      type = lib.types.str;
      default = "wh-m9md18.jpg";
    };
    toml = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = { };
    };
    templatesDir = lib.mkOption {
      type = lib.types.str;
      default = "${matugenDir}/templates";
    };
  };

  config = {
    custom.theming.toml.base = ''
      [config]
      mode = "dark"
      json_format = "hex"
    '';

    hjem.users."${username}" = {
      packages = [
        matugen
        wallScript
      ];
      files."${matugenDir}/matugen.toml".text = lib.concatStringsSep "\n" (lib.attrValues cfg.toml);
    };

    systemd.services.matugen-regen = {
      wantedBy = [ "hjem.target" ];
      after = [ "hjem-activate@${username}.service" ];
      partOf = [ "hjem-activate@${username}.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = username;
        Environment = "HOME=/home/${username}";
      };
      script = ''
        ${lib.getExe wallScript} "/home/${username}/.config/walls/${cfg.wallpaperName}" scheme-tonal-spot
      '';
    };
  };
}
