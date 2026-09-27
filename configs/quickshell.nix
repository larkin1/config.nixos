{ pkgs, config, username, inputs, ... }:

let
  name = "quickshell";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".local/state/quickshell/generated/colors.json";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        quickshell
        wf-recorder # required for screen recording to work
      ];

      files = {
        ".config/quickshell".source = "${inputs.config-quickshell}";
      };
      files = {
        "${input}".text = ''
          {
            "md3": {<* for name, color in colors *>
              "{{ name }}": "{{ color.default.hex }}"<* if {{ loop.last }} *><* else *>,<* endif *><* endfor *>
            },
            "palette": {<* for name, palette in palettes *><* for shade, color in palette *>
              "{{ name }}{{ shade }}": "{{ color.hex }}"<* if {{ loop.last }} *><* else *>,<* endif *><* endfor *><* if {{ loop.last }} *><* else *>,<* endif *><* endfor *>
            },
            "base16": {<* for name, color in base16 *>
              "{{ name }}": "{{ color.default.hex }}"<* if {{ loop.last }} *><* else *>,<* endif *><* endfor *>
            }
          }
        '';
      };
    };
    services.upower.enable = true; # for battery/power monitoring
  };
}
