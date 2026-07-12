{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # --- required ---
    neovim

    # --- tree-sitter ---
    tree-sitter
    gcc

    # --- language servers ---
    lua-language-server
    gopls
    rust-analyzer
    basedpyright
    qt6.qtdeclarative # qmlls
    nil
  ];

  programs.neovim.defaultEditor = true;

  home.file.".config/nvim" = {
    source = "${inputs.config-nvim}";
    recursive = true;
  };
}
