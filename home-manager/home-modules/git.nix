{pkgs, ...}:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Frank";
      userEmail = "frank.boeddeker@gmx.net";
      includes = [
        {
          condition = "gitdir:~/code/gitlab.com/";
          contents = { user.email = "frank.boeddeker@gmx.net"; };
        }
      ];
    };
  };
}

