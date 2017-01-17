# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.device = "/dev/sdb";

  boot.initrd.luks.devices = [
    { name = "rootfs";
      device = "/dev/sdb2";
      preLVM = true;
      allowDiscards = true;  }
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.pulseaudio.enable = true;

  # Configure fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
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

  i18n = {
   consoleFont = "Lat2-Terminus16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
  };

  users.extraUsers.frank = {
    name = "frank";
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
    ];
    createHome = true;
    home = "/home/frank";
    shell = "/run/current-system/sw/bin/zsh";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  powerManagement.enable = true;

 # Enable acpi
  services.acpid.enable = true;
  services.acpid.lidEventCommands = ''
    LID_STATE=/proc/acpi/button/lid/LID0/state
    if [ $(/run/current-system/sw/bin/awk '{print $2}' $LID_STATE) = 'closed' ]; then
      systemctl suspend
    fi
  '';


  # Services
  services.dbus.enable = true;
  services.logind.extraConfig = "HandleLidSwitch=suspend";
  services.xserver = {
    enable = true;
    layout = "en";
    windowManager.i3.enable = true;
    windowManager.default = "i3";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";

    displayManager = {
      slim.enable = true;
      slim.defaultUser = "frank";
    };

    multitouch = {
      enable = true;
      invertScroll = true;
      ignorePalm = true;
    };

    synaptics = {
      enable = true;
      twoFingerScroll = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # nmtui for wifi setup
  environment.systemPackages = with pkgs; [
    i3
    i3status
    i3lock-fancy
    acpi
    feh
    rofi
    tmux
    ranger
    alpine
    which
    htop
    unzip
    chromium
    spotify
    wget
    vim
    terminator
    git
    slack

    # Scala
    sbt
    idea.idea-community
  ];


  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
