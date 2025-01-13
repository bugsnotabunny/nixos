{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ccache
    clang-tools
    cmake
    cmake-language-server
    conan
    drawio
    gnumake
    krita
    libgcc
    lldb_18
    lua-language-server
    ninja
    python3
    python311Packages.pip
    rust-analyzer
    sshfs
    teams-for-linux
    virtualenv
    vscode-extensions.vadimcn.vscode-lldb
    vscode-langservers-extracted

    appimage-run
    asciiquarium
    brightnessctl
    btop
    chromium
    cloc
    curl
    duf
    dunst
    evince
    evolution
    evolution-ews
    fastfetch
    ffmpeg-full
    firefox
    firefox
    git
    gitui
    gparted
    grim
    grimblast
    imagemagick
    kitty
    libreoffice-fresh
    lutris
    lutris
    mattermost-desktop
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
    uwufetch
    viewnior
    vlc
    vscode
    vulkan-tools
    vulkan-tools
    wayland-utils
    wget
    wine
    winetricks
    wineWowPackages.wayland
    wl-clipboard
    wlogout
    wofi
    xdg-utils
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xwaylandvideobridge
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.dconf.enable = true;
}
