{
  services.greetd.enable = true;

  programs.regreet = {
    enable = true;
    settings = {
      background.fit = "Contain";

      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Tokionight Dark";
        icon_theme_name = "Tokionight Dark";
        theme_name = "Tokionight Dark";

        # Font name and size
        font_name = "Cantarell 16";
      };
    };
    cageArgs = [
      "-s"
      "-m"
      "last"
    ];
  };
}
