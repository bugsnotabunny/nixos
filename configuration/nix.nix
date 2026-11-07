{ config, ... }:
let
in
{
  nix = {
    extraOptions = ''
      extra-substituters = 
      extra-trusted-public-keys = 
    '';

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "root"
        config.username
      ];

      auto-optimise-store = true;
      connect-timeout = 10;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
