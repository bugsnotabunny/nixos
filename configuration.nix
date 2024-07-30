{ pkgs, ... }:
let
  # username = "dmalakhov";
  # usernameFull = "Dmitriy Malakhov";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    ./hardware-configuration.nix
    
    ./locale.nix
    ./bluetooth.nix
    ./cpu-scaling.nix
    ./graphics-driver.nix 
    ./networking.nix

    ./shell.nix
    ./greeter.nix 
    ./users.nix
    ./xdg.nix
    ./docker.nix

    ./pkgs.nix
    ./programs.nix

    (import "${home-manager}/nixos")
  ];

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
  sound.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  time.timeZone = "Europe/Moscow";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

  # home.enableNixpkgsReleaseCheck = false;
  home-manager.backupFileExtension = "backup";

  home-manager.users.dmalakhov = {
    home.stateVersion = "24.05";

    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyo-night-gtk;
      };
      iconTheme = {
        name = "Tokyonight-Dark";
      };
    };
    services.blueman-applet.enable = true;
  };

  security.pki.certificateFiles = [
    ./tel.yadro.com.crt
  ];
}
