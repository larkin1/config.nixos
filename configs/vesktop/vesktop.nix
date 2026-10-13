{ pkgs, config, username, ... }:

let
  name = "vesktop";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/themes/midnight-discord.css";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        vesktop
      ];

      files = {
        "${input}".source = ./vesktop.css;
      };
    };
  };
}
