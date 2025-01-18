{ username, usernameFull }:
{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = usernameFull;
    extraGroups = [ "audio" "docker" "input" "networkmanager" "video" "wheel" ];
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.${username} = { pkgs, ... }: {
    nixpkgs.overlays = [ (import ./pkgs) ];
    home = {
      enableNixpkgsReleaseCheck = true;
      stateVersion = "25.05";
      packages = with pkgs; [ ktalk ];
    };
    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyo-night-gtk;
      };
      iconTheme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyo-night-gtk;
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

      portal = let
        packages = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      in {
        enable = true;
        extraPortals = packages;
        configPackages = packages;
      };
    };

    programs.waybar = {
      enable = true;
      style = ./home/waybar/style.css;
      settings = {
        mainBar =
          builtins.fromJSON (builtins.readFile ./home/waybar/config.json);
      };
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        set number relativenumber
      '';
    };

    programs.helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [ marksman nil ];
      languages.language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
      }];
      settings = builtins.fromTOML (builtins.readFile ./home/helix/config.toml);
    };

    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = usernameFull;
      userEmail = "d.malakhov@yadro.com";
      extraConfig = {
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
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

      shellAliases = {
        kssh = "kitten ssh";
        nix-zshell = "nix-shell --run zsh";
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
    home.file.".config/hypr".source = ./home/hypr;

    xdg.desktopEntries = {
      talk = {
        name = "Talk";
        genericName = "Conferencing";
        exec = "appimage-run /home/dmalakhov/bin/ktalk.AppImage";
        terminal = false;
        categories = [ ];
        mimeType = [ "x-scheme-handler/ktalk" ];
      };
    };
  };
}
