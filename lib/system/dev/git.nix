_:

{
  programs.git = {
    enable = true;
    config = [
      {
        init = {
          defaultBranch = "main";
        };
        user = {
          email = "git@sprk.foo";
          name = "larkin1";
        };
      }
    ];
  };
}
