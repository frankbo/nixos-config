# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/t480s>
      ./hardware-configuration.nix
      /home/frank/Code/nixos-config/nixos/umlauts.nix
    ];
  
  nix.useSandbox = false;
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices = [
   {
    name = "root";
    device = "/dev/nvme0n1p2";
    preLVM = true;
   }
  ];


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

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    vim
    which
    htop
    powertop
    git

    vpnc
    networkmanager_vpnc
    networkmanagerapplet
    openfortivpn
    redis

    i3 i3status i3lock-fancy i3blocks-gaps feh
    acpi
    rofi
    tmux
    ranger
    slack
    spotify
    zoom-us
    libreoffice
    flameshot

    chromium
    firefox
    evince
    dunst
    
    terminator
    alacritty
    
    nodejs
    vscode 

    sbt
    idea.idea-ultimate

    xorg.xbacklight
  ];

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.nvidiaOptimus.disable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.frank = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager" "systemd-journal" "vboxusers" "docker"];
    isNormalUser = true;
    home = "/home/frank";
    uid = 1000;
    shell = "/run/current-system/sw/bin/zsh";
  };

  services.acpid.enable = true;
  services.dbus.enable = true;
  # services.logind.lidSwitch = "suspend";
  services.tlp.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.xterm.enable = false;
    desktopManager.plasma5.enable = true;

    displayManager = {
      lightdm.enable = true;
      lightdm.autoLogin = {
        enable = true;
        user = "frank";
      };
    };

    synaptics.enable = false;
    libinput.enable = true;
  };

  # virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
