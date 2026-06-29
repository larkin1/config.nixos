{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../common/home/dots.nix
  ];

  # user definition
  home.username = "larkin";
  home.homeDirectory = "/home/larkin";

  # config files
  home.file.".config/hypr/lua/monitors.lua".text = ''
    hl.monitor({
      output = "DP-1",
      mode = "highrr",
      position = "0x0",
      scale = "1",
    })

    hl.monitor({
      output = "DP-2",
      mode = "highrr",
      position = "2560x-300",
      scale = "1",
      transform = 1,
    })

    hl.monitor({
      output = "DP-3",
      mode = "highrr",
      position = "-1080x-300",
      scale = "1",
      transform = 3,
    })  
  '';
   home.file.".config/hypr/lua/devices.lua".text = ''
    hl.device ({
      name="my-epic-mouse",
      sensitivity = -0.5,
    })
  '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    onlyoffice-desktopeditors
    zip
    unzip
    starship
    ripgrep
    jq
    eza 
    zoxide
    bat
    fzf 
    nix-output-monitor
    glow 
    btop  
    firefox
    google-chrome
    hyprland
    hypridle
    hyprpaper
    hyprcursor
    grim
    slurp
    cliphist
    rose-pine-hyprcursor
    bemoji
    satty
    waybar
    fuzzel
    ghostty
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    tree-sitter
    vesktop
    cava
    yazi
    timg
    libnotify
    dunst
    wl-clipboard
    gcc
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "larkin1";
      user.email = "88820972+larkin1@users.noreply.github.com";
    };
  };

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    # enabledCustomApps = with spicePkgs.apps; [
    #   newReleases
    #   ncsVisualizer
    # ];
    enabledSnippets = with spicePkgs.snippets; [
      # rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.hazy;
    # colorScheme = "mocha";
  };

  programs.zsh = {
    enable = true;
  
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  
    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      share = true;
    };
  
    initContent = ''
      bindkey -v
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
  
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  
      export EDITOR=nvim
      export VISUAL=nvim
      export GOPATH="$HOME/.go"
      export GOBIN="$GOPATH/bin"
      export PATH="$HOME/.cargo/bin:$HOME/.go/bin:$PATH"
      export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  
      eval "$(zoxide init zsh --cmd cd)"
      eval "$(starship init zsh)"
    '';
  

    shellAliases = {
      # ls stuff
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      lta = "eza --tree --icons -a";
      
      # cat stuff
      cat = "bat -n --paging=never";
      less = "bat -n --paging=always";
    };
  };

  services.playerctld.enable = true;
  
  # safe to ignore
  home.stateVersion = "26.05";
}
