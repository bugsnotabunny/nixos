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
      [ "olm-3.2.16" "mbedtls-2.28.10" "qtwebengine-5.15.19" ];

    environment.systemPackages = (with pkgs; [
      appimage-run
      asciiquarium
      bibata-cursors
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
      git
      gitui
      gparted
      imagemagick
      kitty
      libreoffice-fresh
      onlyoffice-desktopeditors
      p7zip
      qbittorrent
      quickemu
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
      xdg-terminal-exec
      xdg-utils
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      zed-editor
      nixd
      marksman
    ]) ++ (with pkgs.unstable; [ yandex-music grim grimblast ])
      ++ (with inputs; [ nix-alien.packages.${system}.nix-alien ]);

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = pkgs.unstable.hyprland;
    };

    programs.nix-ld.enable = true;
    programs.dconf.enable = true;
  };
}
