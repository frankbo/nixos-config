{pkgs, ...}:
{
  home.packages = with pkgs; [ coredns ];

  home.file = {
    "Coredns".text = import ../programs/corefile.nix pkgs;
  };
}

