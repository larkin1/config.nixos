{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    starship
    ripgrep
    eza
    zoxide
    bat
    fzf
  ];

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
}
