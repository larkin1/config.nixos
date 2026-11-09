{ ... }:

{
  programs.git = {
    enable = true;
    config = [
      {
        init = {
          defaultBranch = "main";
        };
        user = {
          email = "88820972+larkin1@users.noreply.github.com";
          name = "larkin1";
        };
      }
    ];
  };
}
