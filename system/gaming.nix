{ lib, config, pkgs, ... }: {
  options = with lib; { doGaming = mkEnableOption { }; };

  config = lib.mkIf (config.doGaming) {
    environment.systemPackages = with pkgs; [
      winetricks
      lutris
      vulkan-tools
      vulkan-loader
      mangohud
    ];

    programs.gamemode.enable = true;

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}

