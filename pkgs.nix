{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    ranger
    cloc
    teams-for-linux
    thunderbird
    pavucontrol
    vlc
    alacritty
    drawio
    unzip
    gnumake
    krita
    boost
    valgrind
    gf
    gdb
    evince
    tigervnc
    gitui
    firefox
    gparted
    cmake
    ninja
    ccache
    mold
    lld
    fastfetch
    tree
    curl
    wget
    git
    duf
    btop
    appimage-run
    docker-compose
    xdg_utils

    wl-clipboard
    pamixer
    brightnessctl
    swaylock
    dunst
    grim
    grimblast
    wlogout
    wofi
    hyprland
    xfce.thunar
    xwaylandvideobridge
    kitty
    swaybg
    viewnior

    mattermost-desktop
    telegram-desktop
    evolution-ews
    evolutionWithPlugins

    ninja
    python3
    virtualenv
    python311Packages.pip
    clang-tools
    lldb
    libgcc
    rustup

    qbittorrent
    qutebrowser
    libreoffice-fresh
    vscode
    imagemagick
    neofetch
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
