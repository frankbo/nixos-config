{pkgs, ...}:
{
  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    i3 i3status i3lock-fancy i3blocks-gaps polybar feh
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager = {
      i3.enable = true;
      i3.package = pkgs.i3-gaps;
      default = "i3";
    };
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager = {
      lightdm = {
        enable = true;
        autoLogin = {
          enable = true;
          user = "frank";
        };
      };
    };

    synaptics.enable = false;
    libinput.enable = true;
   };
}