{ pkgs, ... }:
{
  xdg = {
    portal.enable = true;
    mime.enable = true;
    menus.enable = true;
    icons.enable = true;
    autostart.enable = true;
  };
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];
  xdg.mime.defaultApplications = {
    "text/html" = "qutebrowser.desktop";
    "x-scheme-handler/http" = "qutebrowser.desktop";
    "x-scheme-handler/https" = "qutebrowser.desktop";
    "x-scheme-handler/about" = "qutebrowser.desktop";
    "x-scheme-handler/unknown" = "qutebrowser.desktop";
  };
}
