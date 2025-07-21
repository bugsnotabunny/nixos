{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    asciiquarium
    brightnessctl
    btop
    cloc
    curl
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
    kitty
    krita
    libreoffice-fresh
    nb
    nheko
    p7zip
    pamixer
    pavucontrol
    playerctl
    qbittorrent
    ranger
    smile
    swaybg
    swaylock
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
    yandex-music
    yazi
    zed-editor
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
  };

  programs.dconf.enable = true;
}
