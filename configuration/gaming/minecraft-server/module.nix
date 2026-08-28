{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = with lib; {
    minecraftServer = mkEnableOption { };
  };

  config = lib.mkIf (config.minecraftServer) {
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      dataDir = "/srv/minecraft";
      user = config.username;
      servers.nigger = {
        enable = true;
        autoStart = true;
        restart = "always";
        jvmOpts = "-Xms1024M -Xmx24576M";
        package = pkgs.neoforgeServers.neoforge-21_1_196;
        symlinks = {
          "mods" = ./mods;
        };
        operators = {
          katkek = {
            uuid = "e5e9f7f1-3530-382f-aae2-5a774ecdc4e3";
            level = 4;
          };
        };
        serverProperties = {
          server-port = 43000;
          difficulty = "hard";
          gamemode = "survival";
          white-list = false;
          log-ips = true;
          online-mode = false;
          simulation-distance = 16;
          view-distance = 16;
        };
      };
    };
  };
}
