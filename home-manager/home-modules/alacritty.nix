{pkgs, ...}:

{
  home.packages = with pkgs; [ alacritty ];

  xdg.configFile = {
    "alacritty/alacritty.yml".text = import ../programs/alacritty.yml.nix pkgs;
  };
}
