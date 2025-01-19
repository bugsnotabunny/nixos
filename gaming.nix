{ lib, config, pkgs, ... }: {
  options = with lib; { doGaming = mkEnableOption { }; };

  config = lib.mkIf (config.isWorkstation) {
    environment.systemPackages = with pkgs; [
      lutris
      vulkan-tools
      winetricks
      wineWowPackages.wayland
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}

