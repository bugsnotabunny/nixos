{ inputs, config, lib, ... }: {
  options = with lib; {
    username = mkOption { type = types.str; };
    usernameFull = mkOption {
      type = types.str;
      default = config.username;
    };
  };

  config = let defaultGtkTheme = "Tokyonight-Dark";
  in {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.username} = {
      isNormalUser = true;
      description = config.usernameFull;
      extraGroups =
        [ "audio" "docker" "input" "networkmanager" "video" "wheel" ];
    };

    home-manager.backupFileExtension = "backup";
    home-manager.users.${config.username} = { pkgs, ... }:
      let
        defaultGtkPackage = pkgs.tokyo-night-gtk;
        defaultGtkThemeAndPackage = {
          name = defaultGtkTheme;
          package = defaultGtkPackage;
        };
      in {
        imports = [ inputs.zen-browser.homeModules.twilight ];

        home = {
          enableNixpkgsReleaseCheck = true;
          stateVersion = "25.05";
          sessionVariables = {
            GTK_THEME = defaultGtkTheme;
            ICON_THEME = "Adwaita";
            XCURSOR_THEME = "Bibata-Modern-Ice";
            XCURSOR_SIZE = "28";
          };

          pointerCursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 28;

            x11.enable = true;
            gtk.enable = true;
          };
        };

        gtk = {
          enable = true;
          font = {
            name = "JetBrainsMono Nerd Font";
            size = 14;
          };
          theme = defaultGtkThemeAndPackage;
          iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme-legacy;
          };
        };

        xdg = {
          enable = true;
          mimeApps.enable = true;

          mimeApps.defaultApplications = {
            "application/pdf" = "org.gnome.Evince.desktop";
            "image/png" = "viewnior.desktop";
            "x-scheme-handler/http" = "zen-twilight.desktop";
            "x-scheme-handler/https" = "zen-twilight.desktop";
            "x-scheme-handler/terminal" = "kitty.desktop";
          };

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
            mainBar =
              builtins.fromJSON (builtins.readFile ./waybar/config.json);
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

        programs.zen-browser = {
          enable = true;
          policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = true;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
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
            ".config/zed".source = ./zed;
          };
      };
  };
}
