{ config, pkgs, username, ... }:

{
  programs.zsh.enable = true;

  users.users."${username}" = {
    shell = pkgs.zsh;
  };

  hjem.users."${username}" = {
    packages = with pkgs; [
      # Required/Aliased
      starship
      eza
      bat
      zoxide
      fzf

      # Nice to have
      ripgrep
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

        autoload -U compinit && compinit

        setopt HIST_FCNTL_LOCK
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_SPACE
        setopt SHARE_HISTORY
        setopt NO_APPEND_HISTORY
        setopt NO_EXTENDED_HISTORY
        setopt NO_HIST_EXPIRE_DUPS_FIRST
        setopt NO_HIST_FIND_NO_DUPS
        setopt NO_HIST_IGNORE_ALL_DUPS
        setopt NO_HIST_SAVE_NO_DUPS

        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

        export HELPDIR="${zsh}/share/zsh/$ZSH_VERSION/help"
        export HISTFILE="/home/${username}/.zsh_history"
        export HISTSIZE="10000"
        export SAVEHIST="10000"
        export EDITOR=nvim
        export VISUAL=nvim
        export GOPATH="$HOME/.go"
        export GOBIN="$GOPATH/bin"
        export PATH="$HOME/.cargo/bin:$HOME/.go/bin:$PATH"
        export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

        mkdir -p "$(dirname "$HISTFILE")"

        alias -- :q=exit
        alias -- :w='git add -A'
        alias -- cat='bat -n --paging=never'
        alias -- la='eza -la --icons=auto'
        alias -- less='bat -n --paging=always'
        alias -- ll='eza -l --icons=auto'
        alias -- ls='eza --icons=auto'
        alias -- lt='eza --tree --icons=auto'
        alias -- lta='eza --tree --icons=auto -a'

        source ${config.hjem.users."${username}".environment.loadEnv}
        source "${syntax}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        source "${hist}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

        eval "$(zoxide init zsh --cmd cd)"
        eval "$(starship init zsh)"
        FZF_ALT_C_COMMAND= source <(fzf --zsh)

        bindkey -v
        bindkey "^[[A" history-substring-search-up
        bindkey "^[OA" history-substring-search-up
        bindkey "^[[B" history-substring-search-down
        bindkey "^[OB" history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
      '';
    };
  };
}
