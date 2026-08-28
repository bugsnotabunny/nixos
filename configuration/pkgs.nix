{
  system,
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  options.cpuArch = lib.mkOption {
    type = lib.types.str;
    default = "default";
  };

  config = {
    nixpkgs.overlays = [
      inputs.nix-minecraft.overlay
      inputs.nixified-ai.overlays.comfyui
      (import ../pkgsOverlays/optimized.nix config.cpuArch)
      (import ../pkgsOverlays/unstable.nix inputs.nixpkgs-unstable)
      (import ../pkgsOverlays/custom.nix lib)
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "olm-3.2.16"
      "mbedtls-2.28.10"
      "qtwebengine-5.15.19"
    ];

    environment.systemPackages =
      (with pkgs; [
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
        marksman
        nixd
        nixfmt
        onlyoffice-desktopeditors
        p7zip
        qbittorrent
        quickemu
        smile
        swaybg
        swaylock-effects
        system-config-printer
        telegram-desktop
        thunar
        thunar-archive-plugin
        thunar-volman
        tree
        unzip
        viewnior
        vlc
        vscode-fhs
        wayland-utils
        wget
        wl-clipboard
        wlogout
        wofi
        xdg-terminal-exec
        xdg-utils
      ])
      ++ (with pkgs.unstable; [
        grim
        grimblast
        yandex-music
        zed-editor-fhs
      ])
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
