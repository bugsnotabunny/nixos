{ pkgs, ... }:
let
  config = import ./config.nix;
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    "${
      builtins.fetchTarball
      "https://github.com/nix-community/disko/archive/master.tar.gz"
    }/module.nix"
    ./bluetooth.nix
    ./cpu-scaling.nix
    ./fonts.nix
    ./greeter.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./pkgs.nix
    ./shell.nix

    (import ./disko.nix { device = config.rootDevice; })
    (import "${home-manager}/nixos")
    (import ./docker.nix { isWorkstation = config.isWorkstation; })
    (import ./graphics-driver.nix { gpuSettings = config.gpuSettings; })
    (import ./home.nix {
      username = config.username;
      usernameFull = config.usernameFull;
    })
    (import ./networking.nix { hostname = config.hostname; })
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  time.timeZone = config.timezone;

  security.pki.certificateFiles =
    if config.isWorkstation then [ ./tel.yadro.com.crt ] else [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = "https://channels.nixos.org/nixos-unstable";
  };
}
