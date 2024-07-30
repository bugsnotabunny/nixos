{ username, usernameFull, pkgs, ... }:
{
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

  home-manager.users.dmalakhov = {
    programs.git = {
      enable = true;
      userName = "Dmitriy Malakhov";
      userEmail = "d.malakhov@yadro.com";
    };
  	programs.waybar = {  
      enable = true;
  		style = ./programs/waybar/style.css;
  		settings = {
        mainBar = builtins.fromJSON (builtins.readFile ./programs/waybar/config.json);
    	};
  	};

    programs.helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        cmake-language-server
        vscode-langservers-extracted
        rust-analyzer
        lua-language-server
        marksman
        nil
      ];
      settings = builtins.fromTOML (builtins.readFile ./programs/helix/config.toml);
    }; 
    home.file.".config/kitty".source = ./programs/kitty;
    home.file.".config/wofi".source = ./programs/wofi;
    home.file.".config/wlogout".source = ./programs/wlogout;

  
    xdg.desktopEntries = {
      talk = {
        name = "Talk";
        genericName = "Conferencing";
        exec = "appimage-run /home/dmalakhov/bin/ktalk.AppImage";
        terminal = false;
        categories = [];
        mimeType = [ "x-scheme-handler/ktalk" ];
      };
      mattermost = {                                                                                                                                                                                    name = "Mattermost";                                                                                                                                                                            comment = "Mattermost Desktop application for Linux";                                                                                                                                           type = "Application";                                                                                                                                                                           exec = "${pkgs.mattermost-desktop}/bin/mattermost-desktop %U";                                                                                                                                  icon = "${pkgs.mattermost-desktop}/share/mattermost-desktop/app_icon.png";                                                                                                                      terminal = false;                                                                                                                                                                               categories = [ "Network" "InstantMessaging"];                                                                                                                                                   mimeType = [ "x-scheme-handler/mattermost" ];                                                                                                                                                 }; 
    };
  };
}
