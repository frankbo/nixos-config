{ pkgs, ... }:
{
  users.users.frank.packages = [
    pkgs.steam
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
