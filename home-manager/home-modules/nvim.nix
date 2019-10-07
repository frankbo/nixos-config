{pkgs, ...}:
{
  home.packages = with pkgs; [ neovim vimPlugins.fzfWrapper vimPlugins.vim-plug];

  xdg.configFile = {
    "nvim/init.vim".text = import ../programs/init.vim.nix pkgs;
  };
}
