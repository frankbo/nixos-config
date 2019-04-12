{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/t480s>
      /etc/nixos/hardware-configuration.nix
      ../modules/umlauts.nix
      ../modules/fonts.nix
      ../modules/common-packages.nix
      ../modules/users.nix
      ../modules/i3.nix
      ../modules/common-settings.nix
      ../modules/virtualization.nix
      ../modules/games.nix
    ];
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices = [
   {
    name = "root";
    device = "/dev/nvme0n1p2";
    preLVM = true;
   }
  ];

  # Enable sound.
  # sound.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.nvidiaOptimus.disable = true;
  environment.etc."X11/Xresources".text = ''
     Xft.dpi: 144
  '';
  environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  environment.variables.GDK_SCALE = "2";
  environment.variables.GDK_DPI_SCALE = "0.5";

  services.tlp.enable = true;
  services.xserver = {
    dpi = 144;
    displayManager = {

     sessionCommands = with pkgs; lib.mkAfter
     ''
       ${pkgs.xorg.xrdb}/bin/xrdb -merge ~/.Xresources &
       ${pkgs.xorg.xrdb}/bin/xrdb -merge /etc/X11/Xresources &
       ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr &
       ${pkgs.networkmanagerapplet}/bin/nm-applet &
     '';
   };
  };

  system.stateVersion = "18.09";
}
