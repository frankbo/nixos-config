{pkgs, ...}:
let
  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
in
{
  home.packages = with pkgs; [ unstable.neovim vimPlugins.fzfWrapper vimPlugins.vim-plug];

  xdg.configFile = {
    "nvim/init.vim".text = import ../programs/init.vim.nix pkgs;
  };
}
