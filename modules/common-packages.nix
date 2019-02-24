{ pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
in
{
  environment.systemPackages = with pkgs; [
    wget which htop powertop
    emacs vim vscode
    git
    acpi
    rofi
    tmux
    ranger
    redis
    evince
    ngrok

    # Network
    vpnc networkmanager_vpnc networkmanagerapplet openfortivpn

    # Media
    slack
    spotify

    # Email
    neomutt
    thunderbird

    # To get make hopefully
    glpk

    # Browser
    chromium
    firefox

    # Notification
    dunst

    # Remote desktop
    teamviewer

    # Automatically detect external screens
    grobi

    # Screenshots
    unstable.flameshot

    # Video
    vlc

    # Office
    libreoffice

    terminator alacritty
    weechat
    xlibs.xbacklight xclip

    # Nodejs
    nodejs

    # Scala
    sbt
    idea.idea-community
    idea.idea-ultimate
  ];
}