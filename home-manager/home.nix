{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/tmux.nix
    ./home-modules/alacritty.nix
    ./home-modules/shell.nix
    ./home-modules/dns.nix
    ./home-modules/git.nix
    ./home-modules/nvim.nix
  ]; 

  nixpkgs = {
    config = { allowUnfree = true; };
  };

  home.packages = with pkgs; [
    nodejs-12_x
    nmap
    wget
    dirb
    htop
    ngrok
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
