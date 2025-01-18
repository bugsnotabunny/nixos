{ pkgs, ... }:
let local = import ./local.nix;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./bluetooth.nix
    ./cpu-scaling.nix
    ./fonts.nix
    ./greeter.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./shell.nix
    ./networking.nix

    (import ./pkgs.nix { username = local.username; })
    (import ./disko.nix { device = local.rootDevice; })
    (import ./docker.nix { isWorkstation = local.isWorkstation; })
    (import ./graphics-driver.nix { gpuSettings = local.gpuSettings; })
    (import ./home.nix {
      username = local.username;
      usernameFull = local.usernameFull;
    })
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
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

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  time.timeZone = local.timezone;

  security.pki.certificateFiles =
    if local.isWorkstation then [ ./tel.yadro.com.crt ] else [ ];

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
