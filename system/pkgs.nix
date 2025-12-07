{ system, config, lib, inputs, pkgs, ... }: {
  options.cpuArch = lib.mkOption {
    type = lib.types.str;
    default = "default";
  };

  config = {
    nixpkgs.overlays = [
      inputs.nix-minecraft.overlay
      inputs.nixified-ai.overlays.comfyui
      (import ../pkgsOverlays/custom.nix lib)
      (import ../pkgsOverlays/optimized.nix config.cpuArch)
      (import ../pkgsOverlays/unstable.nix inputs.nixpkgs-unstable)
    ];

    nixpkgs.config.permittedInsecurePackages =
      [ "olm-3.2.16" "mbedtls-2.28.10" ];

    environment.systemPackages = (with pkgs; [
      bibata-cursors
      xdg-terminal-exec
      appimage-run
      asciiquarium
      brightnessctl
      btop
      cloc
      curl
      devenv
      duf
      dunst
      evince
      fastfetch
      ffmpeg-full
      gimp
      git
      gitui
      gparted
      grim
      grimblast
      imagemagick
      jre8
      kitty
      krita
      libreoffice-fresh
      nb
      nheko
      onlyoffice-desktopeditors
      p7zip
      qbittorrent
      quickemu
      ranger
      smile
      swaybg
      swaylock-effects
      system-config-printer
      telegram-desktop
      tree
      unzip
      viewnior
      vlc
      wayland-utils
      wget
      wl-clipboard
      wlogout
      wofi
      xdg-utils
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      yazi
      zed-editor
    ]) ++ (with pkgs.unstable; [ yandex-music ])
      ++ (with inputs; [ nix-alien.packages.${system}.nix-alien ]);

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = pkgs.hyprland;
    };

    programs.nix-ld.enable = true;
    programs.dconf.enable = true;
  };
}
