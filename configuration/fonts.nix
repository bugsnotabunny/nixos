{ pkgs, ... }: {
  fonts.packages = with pkgs; [ noto-fonts nerd-fonts.jetbrains-mono ];

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      emoji = [ "Noto Emoji" ];
    };
  };
}
