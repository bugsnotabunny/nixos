{ config, lib, ... }: {
  options = with lib; {
    username = mkOption { type = types.str; };
    usernameFull = mkOption {
      type = types.str;
      default = config.username;
    };
  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.username} = {
      isNormalUser = true;
      description = config.usernameFull;
      extraGroups =
        [ "audio" "docker" "input" "networkmanager" "video" "wheel" ];
    };

    home-manager.backupFileExtension = "backup";
    home-manager.users.${config.username} = { pkgs, ... }: {
      home = {
        enableNixpkgsReleaseCheck = true;
        stateVersion = "25.05";
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
        cursorTheme = {
          name = "Tokyonight-Dark";
          package = pkgs.tokyo-night-gtk;
        };
      };
      services.blueman-applet.enable = true;

      xdg = {
        enable = true;
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
        style = ./waybar/style.css;
        settings = {
          mainBar = builtins.fromJSON (builtins.readFile ./waybar/config.json);
        };
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        options = [ "--cmd cd" "--no-cmd" ];
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
        settings = builtins.fromTOML (builtins.readFile ./helix/config.toml);
      };

      programs.git = {
        enable = true;
        lfs.enable = true;
        userName = config.usernameFull;
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

      home.file.".config/kitty".source = ./kitty;
      home.file.".config/wofi".source = ./wofi;
      home.file.".config/wlogout".source = ./wlogout;
      home.file.".config/dunst".source = ./dunst;
      home.file.".config/hypr".source = ./hypr;

      xdg.desktopEntries = { };
    };
  };
}
