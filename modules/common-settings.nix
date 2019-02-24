{ pkgs, ... }:
{
  nix.useSandbox = false;
  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  hardware = {
    pulseaudio.enable = true;
  };

  services = {
    acpid.enable = true;
    avahi.enable = true;
    printing.enable = true;
    dbus.enable = true;
    logind.lidSwitch = "suspend";
  };

  powerManagement.enable = true;

  programs.zsh.enable = true;

  time.timeZone = "Europe/Berlin";
}