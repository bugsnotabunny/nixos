{ lib, ... }: {
  services.greetd.enable = true;
  programs.regreet = {
    enable = true;
    settings = {
      background.fit = "Contain";

      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = lib.mkDefault "Tokionight Dark";
        icon_theme_name = lib.mkDefault "Tokionight Dark";
        theme_name = lib.mkDefault "Tokionight Dark";

        # Font name and size
        font_name = "Cantarell 16";
      };
    };
    cageArgs = [ "-s" "-m" "last" ];
  };
}
