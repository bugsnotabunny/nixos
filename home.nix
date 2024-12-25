{ username, usernameFull }:
{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = usernameFull;
    extraGroups = [
      "video"
      "input"
      "audio"
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${username} = 
    import ./home/waybar/mod.nix // 
    import ./home/hypr/mod.nix //
    import ./home/helix/mod.nix { inherit pkgs; } //
  {
    home = {
      enableNixpkgsReleaseCheck = false;
      stateVersion = "24.05";
    };
    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyo-night-gtk;
      };
      iconTheme = {
        name = "Tokyonight-Dark";
      };
    };
    services.blueman-applet.enable = true;

    xdg = {
      mime.enable = true;

       # mime.defaultApplications = {
      #   "text/html" = "qutebrowser.desktop";
      #   "x-scheme-handler/http" = "qutebrowser.desktop";
      #   "x-scheme-handler/https" = "qutebrowser.desktop";
      #   "x-scheme-handler/about" = "qutebrowser.desktop";
      #   "x-scheme-handler/unknown" = "qutebrowser.desktop";
      # };

      portal = let packages = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
      ]; 
      in
      {
        enable = true;
        extraPortals = packages;
        configPackages = packages;
      };
    };

    programs.git = {
      enable = true;
      userName = usernameFull;
      userEmail = "d.malakhov@yadro.com";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;

      sessionVariables = {
        EDITOR = "hx";
        TERMINAL = "kitty";
        BROWSER = "qutebrowser";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "candy";
      };
    };

    home.file.".config/kitty".source = ./home/kitty;
    home.file.".config/wofi".source = ./home/wofi;
    home.file.".config/wlogout".source = ./home/wlogout;
    home.file.".config/dunst".source = ./home/dunst;

    xdg.desktopEntries = {
      talk = {
        name = "Talk";
        genericName = "Conferencing";
        exec = "appimage-run /home/dmalakhov/bin/ktalk.AppImage";
        terminal = false;
        categories = [ ];
        mimeType = [ "x-scheme-handler/ktalk" ];
      };
      mattermost = {
        name = "Mattermost";
        comment = "Mattermost Desktop application for Linux";
        type = "Application";
        exec = "${pkgs.mattermost-desktop}/bin/mattermost-desktop %U";
        icon = "${pkgs.mattermost-desktop}/share/mattermost-desktop/app_icon.png";
        terminal = false;
        categories = [
          "Network"
          "InstantMessaging"
        ];
        mimeType = [ "x-scheme-handler/mattermost" ];
      };
    };
  };
}
