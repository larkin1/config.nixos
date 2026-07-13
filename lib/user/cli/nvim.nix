{ config, pkgs, inputs, username, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      # -- base --
      neovim
      tree-sitter
      gcc
      ripgrep

      # -- language servers --
      lua-language-server
      gopls
      rust-analyzer
      basedpyright
      qt6.qtdeclarative # qmlls
      nil
    ];

    files = {
      ".config/nvim".source = "${inputs.config-nvim}";
    };
  };
}
