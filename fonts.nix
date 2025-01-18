{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];
}
