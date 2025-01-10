{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    vulkan-tools
    wine
    firefox
    lutris

    ccache
    clang-tools
    cmake
    conan
    drawio
    gnumake
    krita
    libgcc
    lldb_18
    ninja
    python3
    python311Packages.pip
    sshfs
    teams-for-linux
    virtualenv
    vscode-extensions.vadimcn.vscode-lldb

    appimage-run
    asciiquarium
    brightnessctl
    btop
    chromium
    cloc
    curl
    discord
    duf
    dunst
    evince
    evolution
    evolution-ews
    fastfetch
    ffmpeg-full
    git
    gitui
    gparted
    grim
    grimblast
    hyprland
    imagemagick
    kitty
    libreoffice-fresh
    mattermost-desktop
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
    uwufetch
    viewnior
    vlc
    vscode
    wayland-utils
    wget
    wl-clipboard
    wlogout
    wofi
    xdg_utils
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xwaylandvideobridge
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.dconf.enable = true;
}
