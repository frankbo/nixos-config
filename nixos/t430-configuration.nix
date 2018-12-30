# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  elmPackages = with pkgs.elmPackages; [
    elm
    elm-format
  ]; 

  hsPackages = with pkgs.haskellPackages; [
    alex
    cabal2nix
    cabal-install
    ghc
    ghcid
    #  ghc-mod
    happy
    hlint
    stack
    stylish-haskell
    hindent
  ];

  gnome3 = with pkgs.gnome3; [
    gnome-screenshot
    evince
    eog
  ];

in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./umlauts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [ {
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  } ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # firewall = {
      # Disabled due to Chromecast problem
      # https://github.com/NixOS/nixpkgs/issues/3107
      # enable = false;
      # allowedTCPPorts = [ 80 443 22 5556 ];
      # allowedUDPPorts = [ 5556 ];
    # };
  };

  hardware.pulseaudio.enable = true;
  powerManagement.enable = true;



  # Configure fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font
      anonymousPro
      corefonts
      dejavu_fonts
      emojione
      fira
      fira-code
      fira-code-symbols
      fira-mono
      freefont_ttf
      liberation_ttf
      # nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      source-sans-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
      powerline-fonts
      font-awesome-ttf
      siji
    ];
  };
  
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    i3 i3status i3lock-fancy i3blocks-gaps polybar feh
    acpi
    rofi
    tmux
    ranger

    # Email
    neomutt
    thunderbird

    which
    htop

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

    terminator
    alacritty
    weechat
    emacs
    xlibs.xbacklight
    xclip

    # Nodejs
    nodejs

    # Scala
    sbt
    idea.idea-community
    vscode

  ] ++ hsPackages ++ elmPackages ++ gnome3;

  programs.zsh.enable = true;

  users.extraUsers.frank = {
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"
    ];
    createHome = true;
    home = "/home/frank";
    shell = "/run/current-system/sw/bin/zsh";
  };

  services.acpid.enable = true;
  services.dbus.enable = true;
  services.logind.extraConfig = "HandleLidSwitch=suspend";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networkeng.firewall.enable = false;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3.package = pkgs.i3-gaps;
    windowManager.i3.enable = true;
    windowManager.default = "i3";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";

    displayManager = {
      slim.enable = true;
      slim.defaultUser = "frank";
    };

    synaptics.enable = false;
    libinput.enable = true;

    config = ''
      Section "InputClass"
        Identifier     "Enable libinput for TrackPoint"
        MatchIsPointer "on"
        Driver         "libinput"
        Option         "ScrollMethod" "button"
        Option         "ScrollButton" "8"
      EndSection
    '';
  };
  virtualisation.docker.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.03";

}
