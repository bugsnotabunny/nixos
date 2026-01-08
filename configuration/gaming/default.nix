{ lib, config, pkgs, ... }: {
  imports = [ ./minecraft-server ];

  options = with lib; { doGaming = mkEnableOption { }; };

  config = lib.mkIf (config.doGaming) {
    environment.systemPackages = with pkgs; [
      teamspeak3
      teamspeak6-client
      lutris
      mangohud
      vulkan-loader
      vulkan-tools
      winetricks
    ];

    services.tailscale.enable = true;

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

