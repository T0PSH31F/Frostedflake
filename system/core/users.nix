{pkgs, ...}: {
  users.users.t0psh31f = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "adbusers"
      "input"
      "libvirtd"
      "networkmanager"
      "docker"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };
}
