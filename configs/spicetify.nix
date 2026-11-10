{
  inputs,
  pkgs,
  config,
  username,
  ...
}:

let
  name = "spicetify";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".cache/matugen/${name}.json";
  port = "9222";

  # Push the current matugen colours into a running Spotify over DevTools.
  pushColors = pkgs.writeShellApplication {
    name = "spicetify-push";
    runtimeInputs = with pkgs; [
      curl
      jq
      websocat
    ];
    text = ''
      colors="$HOME/${output}"
      [[ -r $colors ]] || exit 1
      ws=$(curl -sf http://127.0.0.1:${port}/json \
        | jq -r 'map(select(.type == "page" and (.url | test("xpui")))) | first | .webSocketDebuggerUrl // empty') \
        || exit 1
      [[ -n $ws ]] || exit 1
      js="((c)=>{const s=document.documentElement.style;for(const[k,v]of Object.entries(c)){s.setProperty('--spice-'+k,'#'+v);s.setProperty('--spice-rgb-'+k,[0,2,4].map(i=>parseInt(v.slice(i,i+2),16)).join(','))}})($(jq -c . "$colors"))"
      jq -cn --arg e "$js" '{id: 1, method: "Runtime.evaluate", params: {expression: $e}}' \
        | websocat -1 "$ws" >/dev/null
    '';
  };

  # Launch Spotify with DevTools enabled, then push colours once it's up.
  spotifyLive = pkgs.writeShellApplication {
    name = "spotify-live";
    runtimeInputs = [ pushColors ];
    text = ''
      spotify --remote-debugging-port=${port} "$@" &
      for _ in {1..60}; do
        spicetify-push >/dev/null 2>&1 && break
        sleep 0.5
      done
      wait
    '';
  };
in
{
  config = {
    hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];

    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = "${pushColors}/bin/spicetify-push || true"
    '';

    hjem.users."${username}" = {
      packages = [ spotifyLive ];

      files = {
        "${input}".text = ''
          {
            "main": "{{ colors.background.default.hex_stripped }}",
            "main-secondary": "{{ colors.surface_bright.default.hex_stripped }}",
            "accent": "{{ colors.primary.default.hex_stripped }}",
            "button": "{{ colors.primary.default.hex_stripped }}",
            "button-secondary": "{{ colors.secondary.default.hex_stripped }}",
            "button-active": "{{ colors.primary_fixed.default.hex_stripped }}",
            "button-disabled": "{{ colors.surface_bright.default.hex_stripped }}",
            "misc": "{{ colors.tertiary.default.hex_stripped }}",
            "subtext": "{{ colors.on_surface_variant.default.hex_stripped }}",
            "text": "{{ colors.on_background.default.hex_stripped }}",
            "sidebar": "{{ colors.surface.default.hex_stripped }}",
            "player": "{{ colors.surface.default.hex_stripped }}",
            "card": "{{ colors.surface_bright.default.hex_stripped }}",
            "notification": "{{ colors.surface.default.hex_stripped }}",
            "notification-error": "{{ colors.error.default.hex_stripped }}",
            "shadow": "{{ colors.shadow.default.hex_stripped }}",
            "nav-active-text": "{{ colors.primary.default.hex_stripped }}",
            "nav-active": "{{ colors.primary.default.hex_stripped }}",
            "tab-active": "{{ colors.surface.default.hex_stripped }}",
            "play-button": "{{ colors.primary.default.hex_stripped }}",
            "playback-bar": "{{ colors.primary_fixed.default.hex_stripped }}"
          }
        '';

        # Shadows the system spotify.desktop so launchers start spotify-live.
        ".local/share/applications/spotify.desktop".text = ''
          [Desktop Entry]
          Type=Application
          Name=Spotify
          Exec=spotify-live %U
          Icon=spotify-client
          Categories=Audio;Music;Player;AudioVideo;
          MimeType=x-scheme-handler/spotify;
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

          # Fallback until the first live push lands.
          customColorScheme = {
            main = "111111";
            main-secondary = "1c1c1c";
            accent = "89b4fa";
            button = "89b4fa";
            button-secondary = "89b4fa";
            button-active = "89b4fa";
            button-disabled = "313244";
            misc = "313244";
            subtext = "cdd6f4";
            text = "ffffff";
            sidebar = "111111";
            player = "111111";
            card = "1c1c1c";
            notification = "111111";
            notification-error = "f38ba8";
            shadow = "000000";
            nav-active-text = "89b4fa";
            nav-active = "89b4fa";
            tab-active = "111111";
            play-button = "89b4fa";
            playback-bar = "89b4fa";
          };
        };
    };
  };
}
