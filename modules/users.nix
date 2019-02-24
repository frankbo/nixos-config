{...}:
{
  users.extraUsers.frank = {
    group = "users";
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "vboxusers" "docker"
    ];
    createHome = true;
    home = "/home/frank";
    shell = "/run/current-system/sw/bin/zsh";
  };
}