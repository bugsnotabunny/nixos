{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
