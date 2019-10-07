{pkgs, ...}:

{
  home.packages = with pkgs; [ zsh oh-my-zsh fzf ranger ];
  
  home.file = {
    ".zshrc".text = import ../programs/zshrc.nix pkgs;
  };
}

