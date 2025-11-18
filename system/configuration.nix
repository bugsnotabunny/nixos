{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./bluetooth.nix
    ./cpu-scaling.nix
    ./docker.nix
    ./fonts.nix
    ./graphics-driver.nix
    ./greeter.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./networking.nix
    ./pkgs.nix
    ./shell.nix
    ./batteries.nix
    ./printing.nix
  ];

  nix.extraOptions = ''
    extra-substituters = 
    extra-trusted-public-keys = 
  '';
  nix.settings = {
    substituters = [
      "https://nixpkgs-python.cachix.org"
      "https://devenv.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://ai.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  boot = {
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_xanmod;

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

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
