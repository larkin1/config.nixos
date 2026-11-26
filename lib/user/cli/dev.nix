_:

{
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
  ];

  programs = {
    direnv.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;
  };
}
