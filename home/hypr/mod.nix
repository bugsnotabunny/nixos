{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  home.file.".config/hypr".source = ./programs/hypr;
}
