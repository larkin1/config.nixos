{ pkgs, config, username, ... }:

let
  name = "ghostty";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/config";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = "pkill -SIGUSR2 ghostty"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        ghostty
      ];

      files = {
        "${input}".source = ./ghostty;
        ".config/${name}/shaders/cursor_warp.glsl".source = ./cursor_warp.glsl;
        ".config/${name}/shaders/cursor_lightning.glsl".source = ./cursor_lightning.glsl;
      };
    };
  };
}
