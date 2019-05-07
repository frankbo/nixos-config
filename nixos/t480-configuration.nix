{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {config = { allowUnfree = true; };};
in
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
  boot.kernelParams = [
    "snd_hda_intel.power_save=1"
    "i915.enable_psr=0"
    "bbswitch.load_state=0"
    "bbswitch.unload_state=1"
  ];

  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.laptop_mode" = 5;
  };

  # Extra packages
  environment.systemPackages = with pkgs; [
    unstable.zoom-us
    gnupg
    git-secret
  ];

  # Enable sound.
  # sound.enable = true;
  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidiaOptimus.disable = true;
    opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
    # opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];
  };

  #environment.etc."X11/Xresources".text = ''
  #   Xft.dpi: 144
  #'';
  # environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  # environment.variables.GDK_SCALE = "2";
  # environment.variables.GDK_DPI_SCALE = "0.5";

  services.tlp.enable = true;

  system.stateVersion = "18.09";
}
