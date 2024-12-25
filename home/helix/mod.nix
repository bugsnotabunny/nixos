{ pkgs }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      cmake-language-server
      vscode-langservers-extracted
      rust-analyzer
      lua-language-server
      marksman
      nil
    ];
    settings = builtins.fromTOML (builtins.readFile ./programs/helix/config.toml);
  };
}
