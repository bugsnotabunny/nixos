{ pkgs, ... }:
{
  imports = [
    ./nix-alien.nix
    ./hardware-configuration.nix
    ./bluetooth.nix
    ./cpu-scaling.nix
    ./graphics-driver.nix 
    ./networking.nix
    ./pkgs.nix
    ./shell.nix
    ./users.nix
    ./xdg.nix
    ./docker.nix
    
    ./greeter.nix 
    ./home-manager.nix
  ];

  security.pki.certificateFiles = [
    ./tel.yadro.com.crt
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;   
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
