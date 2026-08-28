{ config, ... }: {
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  boot = {
    supportedFilesystems.zfs = true;
    zfs.package = config.boot.kernelPackages.zfs_cachyos;

    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      memtest86.enable = true;
    };
    loader.grub2-theme = {
      enable = true;
      theme = "tela";
      footer = true;
    };
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  boot.zfs.forceImportRoot = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  assertions = [
    {
      assertion = builtins.pathExists ./hardware-configuration.nix;
      message = "hardware-configuration.nix is required but not found";
    }
  ];
}
