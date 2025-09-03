{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  environment.systemPackages = with pkgs; [
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
    kitty
    krita
    libreoffice-fresh
    nb
    nheko
    onlyoffice-desktopeditors
    p7zip
    pamixer
    pavucontrol
    playerctl
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
    yandex-music
    yazi
    zed-editor-fhs
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
  };

  programs.dconf.enable = true;
}
