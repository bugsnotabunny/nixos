{ inputs, config, lib, ... }: {
  home-manager.backupFileExtension = "backup";
  home-manager.users.${config.username} = { pkgs, ... }:
    let
      defaultGtkPackage = pkgs.tokyonight-gtk-theme;
      defaultGtkTheme = "Tokyonight-Dark";
    in {
      imports = [ inputs.zen-browser.homeModules.twilight ];

      home = {
        enableNixpkgsReleaseCheck = true;
        stateVersion = "26.05";
        sessionVariables = {
          GTK_THEME = defaultGtkTheme;
          ICON_THEME = "Tela";
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
        theme = {
          name = defaultGtkTheme;
          package = defaultGtkPackage;
        };
        iconTheme = {
          name = "Tela";
          package = pkgs.tela-icon-theme;
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
        extraPackages = with pkgs; [ marksman nixd nixfmt ];
        languages.language = [{
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }];
        settings = builtins.fromTOML (builtins.readFile ./helix/config.toml);
      };

      programs.git = {
        enable = true;
        lfs.enable = true;
        signing.format = "ssh";
        settings = {
          user.name = "Dmitry Malakhov";
          user.email = config.userEmail;
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
            import ./hypr/hyprland.conf.nixexpr config.batteries.enable;
          ".config/zed".source = ./zed;
        };
    };
}
