{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    gopls
    rust-analyzer
    basedpyright
    qt6.qtdeclarative # qmlls
  ];

  programs.neovim.defaultEditor = true;

  home.file.".config/nvim" = {
    source = "${inputs.config-nvim}";
    recursive = true;
  };
}
