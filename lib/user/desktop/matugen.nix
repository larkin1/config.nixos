{ pkgs, lib, config, username, inputs, ... }:

let
  cfg = config.custom.theming;
  matugenDir = ".config/matugen"; # We don't use global paths, as hjem doesn't support them. instead if we need a global path, we prepend /home/${username}/
in {
  options.custom.theming = {
    wallpaperName = lib.mkOption {
      type = lib.types.str;
      default = "wallhaven-j5mz95.png";
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
        ${pkgs.matugen}/bin/matugen image "/home/${username}/.config/walls/${cfg.wallpaperName}" --config "/home/${username}/${matugenDir}/matugen.toml" --source-color-index=0 --type=scheme-content
      '';
    };
  };
}
