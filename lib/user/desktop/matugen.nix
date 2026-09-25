{ pkgs, lib, config, username, inputs, ... }:

let
  cfg = config.custom.theming;
  matugenDir = ".config/matugen"; # We don't use global paths, as hjem doesn't support them. instead if we need a global path, we prepend /home/${username}/
in {
  options.custom.theming = {
    wallpaperName = lib.mkOption {
      description = "any wallpaper name in config-walls";
      type = lib.types.str;
      default = "dark-waves.jpg";
    };
    wallpaperSource = lib.mkOption {
      type = lib.types.path;
      default = "${inputs.config-walls}/${config.custom.theming.wallpaperName}";
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
      packages = with pkgs; [
        inputs.matugen.packages.${system}.default
      ];
      files."${matugenDir}/matugen.toml".text =
        lib.concatStringsSep "\n" (lib.attrValues cfg.toml);
    };

    systemd.services.matugen-regen = {
      wantedBy = [ "hjem.target" ];
      after = [ "hjem-activate@${username}.service" ];
      serviceConfig = {
        Type = "oneshot";
        User = username;
        Environment = "HOME=/home/${username}";
      };
      script = ''
        ${pkgs.matugen}/bin/matugen image "${cfg.wallpaperSource}" --config "/home/${username}/${matugenDir}/matugen.toml" --source-color-index=0 --type=scheme-content
      '';
    };
  };
}
