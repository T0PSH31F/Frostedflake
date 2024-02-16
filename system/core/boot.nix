{
  pkgs,
  config,
  ...
}: {
  boot = {
    bootspec.enable = true;


    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4" "btrfs" "ntfs" ];
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "uas" "usbhid" "sd_mod" ];
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [ "kvm-intel" ];
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    plymouth.enable = true;
  };

  environment.systemPackages = [config.boot.kernelPackages.cpupower];
}
