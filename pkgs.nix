{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
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
    helix
    zellij
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
    rofi
    waybar    
    hyprland
    xfce.thunar
    xwaylandvideobridge    
    kitty
    swaybg
    viewnior

    mattermost-desktop
    telegram-desktop
    discord
    evolution-ews
    evolutionWithPlugins
    
    ninja
    nil
    jre_minimal
    python3
    virtualenv
    python311Packages.pip
    clang-tools
    rocmPackages.llvm.clang
    rocmPackages.llvm.clang-tools-extra
    rocmPackages.llvm.lldb
    libgcc
    rustup
    rust-analyzer
    lua-language-server
    marksman
    
    qbittorrent
    qutebrowser
    libreoffice-fresh
    vscode
    imagemagick
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    nerdfonts
    noto-fonts-color-emoji
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
	
  programs.dconf.enable = true;
}
