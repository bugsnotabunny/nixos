{ lib, pkgs, config, ... }: {
  options.batteries.enable = lib.mkEnableOption { };

  config = lib.mkIf (config.batteries.enable) {
    environment.systemPackages = with pkgs; [ battery-notify ];
  };
}
