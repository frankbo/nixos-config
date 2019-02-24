# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../modules/fonts.nix
      ../modules/umlauts.nix
      ../modules/common-packages.nix
      ../modules/users.nix
      ../modules/i3.nix
      ../modules/common-settings.nix
      ../modules/virtualization.nix
      ../modules/haskell-packages
      ../modules/elm-packages
    ];

  boot.initrd.luks.devices = [ {
    name = "root";
    device = "/dev/sda2";
    preLVM = true;
  } ];

  services.tlp.enable = true;
  services.xserver = {
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

  system.stateVersion = "18.03";
}
