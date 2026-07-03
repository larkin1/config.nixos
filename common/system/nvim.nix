{ config, pkgs, inputs, ... }:

{
  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    neovim
  ];
}
