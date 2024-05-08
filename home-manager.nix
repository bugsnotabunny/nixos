{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.dmalakhov = {
    home.stateVersion = "23.11";
    home.shellAliases = {
      ld = "mold";
    };

    xdg.desktopEntries = {
      talk = {
        name = "Talk";
        genericName = "Conferencing";
        exec = "appimage-run /home/dmalakhov/bin/ktalk.AppImage";
        terminal = false;
        categories = [];
        mimeType = [ "x-scheme-handler/ktalk" ];
      };
      mattermost = {
        name = "Mattermost";
        comment = "Mattermost Desktop application for Linux";
        type = "Application";
        exec = "${pkgs.mattermost-desktop}/bin/mattermost-desktop %U";
        icon = "${pkgs.mattermost-desktop}/share/mattermost-desktop/app_icon.png";
        terminal = false;
        categories = [ "Network" "InstantMessaging"];
        mimeType = [ "x-scheme-handler/mattermost" ];
      };
    };
  };
}
