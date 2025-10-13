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
        extraPackages = with pkgs; [ marksman nixd nixfmt-classic ];
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
        userName = "Dmitry Malakhov";
        userEmail = "d.malakhov@yadro.com";
        signing.format = "ssh";
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
          BROWSER = "zen";
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

      home.file =
        let forceAll = lib.mapAttrs (_: value: value // { force = true; });
        in forceAll {
          ".config/kitty".source = ./kitty;
          ".config/wofi".source = ./wofi;
          ".config/wlogout".source = ./wlogout;
          ".config/dunst".source = ./dunst;
          ".config/battery-notify".source = ./battery-notify;
          ".config/hypr/hyprland.conf".text =
            import ./hypr/hyprland.conf.nix config.batteries.enable;
        };
    };
  };
}
