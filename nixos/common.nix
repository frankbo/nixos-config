{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  hardware.pulseaudio.enable = true;
  powerManagement.enable = true;

  # Configure fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono
      font-awesome-ttf
      anonymousPro
      corefonts
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
    ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    i3 i3status i3lock-fancy i3blocks-gaps feh
    acpi
    rofi
    tmux
    ranger
    vscode

    # Email
    neomutt
    thunderbird

    which
    htop

    # Browser
    chromium
    firefox

    # PDF reader 
    evince

    # Notification
    dunst

    # Automatically detect external screens
    grobi

    terminator
    weechat
    emacs
    xlibs.xbacklight
    xclip

    # Nodejs
    nodejs

    # Scala
    sbt
  ];

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

  services = {
    acpid.enable = true;
    logind.lidSwitch = "suspend";
    xserver = {
      enable = true;
      layout = "us";
      windowManager = {
        i3.enable = true;
        i3.package = pkgs.i3-gaps;
        default = "i3";
      };
      desktopManager = {
          xterm.enable = false;
          default = "none";
      };

      displayManager = {
        slim.enable = true;
        slim.defaultUser = "frank";
          sessionCommands = ''
            ${pkgs.xlibs.xset}/bin/xset r rate 200 25  # set the keyboard repeat rate
          '';
      };
    };
  };
}
