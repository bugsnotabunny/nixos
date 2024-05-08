{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "candy";
    };
  };
}
