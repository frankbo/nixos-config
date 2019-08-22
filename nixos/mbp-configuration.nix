## This config is deprecated and no longer maintained ##

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./common.nix
      ./umlauts.nix
    ];

  boot.initrd.luks.devices = [{
    name = "root";
    device = "/dev/disk/by-uuid/d44ab239-5e04-42a2-8c80-2ed0c07cacfc";
    preLVM = true;
  }];

  environment.systemPackages = with pkgs; [
    slack
    jetbrains.idea-ultimate
    openfortivpn
    ngrok
  ];
  
  services.xserver = {
    resolutions = [ { x = 1680; y = 1050;} ];

    multitouch = {
      enable = true;
      invertScroll = true;
    };

    synaptics = {
      fingersMap = [ 0 0 0 ];
      buttonsMap = [ 1 3 2 ];
      additionalOptions = ''
        Option "VertScrollDelta" "-100"
        Option "HorizScrollDelta" "-100"
      '';
      enable = true;
      tapButtons = false;
      twoFingerScroll = true;
    };
  };

  hardware = {
    bluetooth.enable = false;
    facetimehd.enable = true;
  };

  virtualisation.docker.enable = true;

  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  system.stateVersion = "18.03";
}
