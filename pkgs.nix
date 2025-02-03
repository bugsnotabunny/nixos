{ pkgs, ... }: {
  nixpkgs.overlays = [ (import ./pkgsOverlays) ];

  environment.systemPackages = with pkgs; [
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
    firefox
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
