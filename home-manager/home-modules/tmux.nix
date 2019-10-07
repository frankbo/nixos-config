{ pkgs, ... }:

{
  home.packages = with pkgs; [ tmux ];

  home.file = {
    ".tmux.conf".text = import ../programs/tmux.conf.nix pkgs;
  };
}
