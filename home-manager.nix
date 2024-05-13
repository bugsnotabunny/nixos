{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.dmalakhov = {
    home.stateVersion = "24.05";
    xdg.desktopEntries = {
      talk = {
        name = "Talk";
        genericName = "Conferencing";
        exec = "appimage-run /home/dmalakhov/bin/ktalk.AppImage";
        terminal = false;
        categories = [];
        mimeType = [ "x-scheme-handler/ktalk" ];
      };
      # mattermost = {
      #   name = "Mattermost";
      #   comment = "Mattermost Desktop application for Linux";
      #   type = "Application";
      #   exec = "${pkgs.mattermost-desktop}/bin/mattermost-desktop %U";
      #   icon = "${pkgs.mattermost-desktop}/share/mattermost-desktop/app_icon.png";
      #   terminal = false;
      #   categories = [ "Network" "InstantMessaging"];
      #   mimeType = [ "x-scheme-handler/mattermost" ];
      # };
    };
    programs.git = {
      enable = true;
      userName  = "d.malakhov";
      userEmail = "d.malakhov@yadro.com";
    };
  	programs.waybar = {  
      enable = true;
  		style = .programs/waybar/style.css;
  		settings = {
        mainBar = builtins.fromJSON (builtins.readFile ./programs/waybar/config.jsonc);
    	};
  	};
  };
}
