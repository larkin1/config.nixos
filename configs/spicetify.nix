{ inputs, pkgs, config, username, ... }:

let
  name = "spicetify";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/Themes/Sleek/color.ini";
in {
  config = {
    hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];

    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = 'pgrep -x spicetify > /dev/null || spicetify apply -n'
    '';

    hjem.users."${username}" = {
      files = {
        "${input}".text = ''
          [custom]
          main               = {{ colors.background.default.hex_stripped }}
          main-secondary     = {{ colors.surface_bright.default.hex_stripped }}
          accent             = {{ colors.primary.default.hex_stripped }}
          button             = {{ colors.primary.default.hex_stripped }}
          button-secondary   = {{ colors.secondary.default.hex_stripped }}
          button-active      = {{ colors.primary_fixed.default.hex_stripped }}
          button-disabled    = {{ colors.surface_bright.default.hex_stripped }}

          misc               = {{ colors.tertiary.default.hex_stripped }}
          subtext            = {{ colors.on_surface_variant.default.hex_stripped }}
          text               = {{ colors.on_background.default.hex_stripped }}
          sidebar            = {{ colors.surface.default.hex_stripped }}
          player             = {{ colors.surface.default.hex_stripped }}
          card               = {{ colors.surface_bright.default.hex_stripped }}
          notification       = {{ colors.surface.default.hex_stripped }}
          notification-error = {{ colors.error.default.hex_stripped }}
          shadow             = {{ colors.shadow.default.hex_stripped }}

          nav-active-text    = {{ colors.primary.default.hex_stripped }}
          nav-active         = {{ colors.primary.default.hex_stripped }}
          tab-active         = {{ colors.surface.default.hex_stripped }}
          play-button        = {{ colors.primary.default.hex_stripped }}

          playback-bar       = {{ colors.primary_fixed.default.hex_stripped }}
        '';
      };

      programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;

        spicetifyPackage = pkgs.spicetify-cli;

        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          skipStats
          sortPlay
        ];

        theme = spicePkgs.themes.sleek;
        colorScheme = "custom";
        
        customColorScheme = {
          main               = "111111";
          main-secondary     = "1c1c1c";
          accent             = "89b4fa";
          button             = "89b4fa";
          button-secondary   = "89b4fa";
          button-active      = "89b4fa";
          button-disabled    = "313244";
          misc               = "313244";
          subtext            = "cdd6f4";
          text               = "ffffff";
          sidebar            = "111111";
          player             = "111111";
          card               = "1c1c1c";
          notification       = "111111";
          notification-error = "f38ba8";
          shadow             = "000000";
          nav-active-text    = "89b4fa";
          nav-active         = "89b4fa";
          tab-active         = "111111";
          play-button        = "89b4fa";
          playback-bar       = "89b4fa";
        };
      };
    };
  };
}
