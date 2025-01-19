{ pkgs, ... }: {
  nixpkgs.overlays = [ (import ./pkgsOverlays) ];

  environment.systemPackages = with pkgs; [
    asciiquarium
    brightnessctl
    btop
    krita
    cloc
    curl
    duf
    dunst
    evince
    fastfetch
    ffmpeg-full
    firefox
    git
    gitui
    gparted
    grim
    grimblast
    imagemagick
    kitty
    libreoffice-fresh
    p7zip
    pamixer
    pavucontrol
    playerctl
    qbittorrent
    qutebrowser
    ranger
    smile
    swaybg
    swaylock
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
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.dconf.enable = true;
}
