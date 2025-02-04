{ lib, config, pkgs, ... }: {
  options = with lib; { doGaming = mkEnableOption { }; };

  config = lib.mkIf (config.doGaming) {
    environment.systemPackages = with pkgs; [
      lutris
      vulkan-tools
      winetricks
      wineWowPackages.wayland
      mangohud
    ];

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}

