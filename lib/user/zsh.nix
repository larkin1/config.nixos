{ config, pkgs, username, ... }:

{
  users.users."${username}" = {
    shell = pkgs.zsh;
  };

  hjem.users."${username}" = {
    packages = with pkgs; [
      starship
      ripgrep
      eza
      zoxide
      bat
      fzf
      fd
    ];

    files = {
      ".zshrc".text = let
        zsh = pkgs.zsh;
        syntax = pkgs.zsh-syntax-highlighting;
        hist = pkgs.zsh-history-substring-search;
      in ''
        typeset -U path cdpath fpath manpath
        for profile in ''${(z)NIX_PROFILES}; do
          fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
        done

        source ${config.hjem.users."${username}".environment.loadEnv}

        HELPDIR="${zsh}/share/zsh/$ZSH_VERSION/help

        autoload -U compinit && compinit
        # History options should be set in .zshrc and after oh-my-zsh sourcing.
        # See https://github.com/nix-community/home-manager/issues/177.
        HISTSIZE="10000"
        SAVEHIST="10000"

        HISTFILE="/home/larkin/.zsh_history"
        mkdir -p "$(dirname "$HISTFILE")"

        # Set shell options
        set_opts=(
          HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
          NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST
          NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
        )
        for opt in "''${set_opts[@]}"; do
          setopt "$opt"
        done
        unset opt set_opts

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

        alias -- :q=exit
        alias -- cat='bat -n --paging=never'
        alias -- la='eza -la --icons'
        alias -- less='bat -n --paging=always'
        alias -- ll='eza -l --icons'
        alias -- ls='eza --icons'
        alias -- lt='eza --tree --icons'
        alias -- lta='eza --tree --icons -a'

        source "${syntax}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

        source "${hist}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
        bindkey "^[[A" history-substring-search-up
        bindkey "^[[B" history-substring-search-down
      '';
    };
  };
}
