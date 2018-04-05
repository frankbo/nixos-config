# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  elmPackages = with pkgs.elmPackages; [
    elm
    elm-format
    elm-make
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
  ];

  gnome3 = with pkgs.gnome3; [
    gnome-screenshot
  ];

in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [ {
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  } ];

  nixpkgs.config.allowUnfree = true;

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
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    i3 i3status i3lock-fancy i3blocks-gaps feh
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

    # PDF reader 
    evince

    # Notification
    dunst

    # Remote desktop
    teamviewer

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
    idea.idea-community
    vscode

  ] ++ hsPackages ++ elmPackages ++ gnome3;

  programs.zsh.enable = true;

  users.extraUsers.frank = {
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
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
  # networking.firewall.enable = false;

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

  # nixpkgs.config.packageOverrides = super: {
  #  xorg = super.xorg // rec {
  #    xkeyboard_config_us_de = super.pkgs.lib.overrideDerivation super.xorg.xkeyboardconfig (old: {
  #      patches = [
  #        (builtins.toFile "us.patch" ''
  #                    +partial default alphanumeric_keys
  #                    +xkb_symbols "us_de" {
  #                    +
  #                    +    include "us"
  #                    +    name[Group1] = "US_DE";
  #                    +
  #                    +    //             Unmodified       Shift           AltGr            Shift+AltGr
  #                    +    // home row, left side
  #                    +    key <AC01> { [ a,               A,              adiaeresis,      Adiaeresis ] };
  #                    +    key <AC02> { [ o,               O,              odiaeresis,      Odiaeresis ] };
  #                    +    key <AC04> { [ u,               U,              udiaeresis,      Udiaeresis ] };
  #                    +};
  #        '')
  #      ];
  #    });

  #      xorgserver = super.pkgs.lib.overrideDerivation super.xorg.xorgserver (old: {
  #      postInstall = ''
  #        rm -fr $out/share/X11/xkb/compiled
  #        ln -s /var/tmp $out/share/X11/xkb/compiled
  #        wrapProgram $out/bin/Xephyr \
  #          --set XKB_BINDIR "${xkbcomp}/bin" \
  #          --add-flags "-xkbdir ${xkeyboard_config_us_de}/share/X11/xkb"
  #        wrapProgram $out/bin/Xvfb \
  #          --set XKB_BINDIR "${xkbcomp}/bin" \
  #          --set XORG_DRI_DRIVER_PATH ${super.mesa}/lib/dri \
  #          --add-flags "-xkbdir ${xkeyboard_config_us_de}/share/X11/xkb"
  #        ( # assert() keeps runtime reference xorgserver-dev in xf86-video-intel and others
  #          cd "$dev"
  #          for f in include/xorg/*.h; do # */
  #            sed "1i#line 1 \"${old.name}/$f\"" -i "$f"
  #          done
  #        )
  #      '';
  #    }); 
  
  #    setxkbmap = super.pkgs.lib.overrideDerivation super.xorg.setxkbmap (old: {
  #      postInstall =
  #        ''
  #        mkdir -p $out/share
  #        ln -sfn ${xkeyboard_config_us_de}/etc/X11 $out/share/X11
  #        '';
  #    });
  
  #    xkbcomp = super.pkgs.lib.overrideDerivation super.xorg.xkbcomp (old: {
  #      configureFlags = "--with-xkb-config-root=${xkeyboard_config_us_de}/share/X11/xkb";
  #    });
  #  };
  #};

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
