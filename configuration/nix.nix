{ config, ... }:
let
  cachesList = [
    {
      sub = "https://cache.nixos.org";
      key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    }
    {
      sub = "https://cache.lantian.pub/lantian";
      key = "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=";
    }
  ];

  setupCaches = {
    substituters = map (item: item.sub) cachesList;
    trusted-public-keys = map (item: item.key) cachesList;
  };
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
    }
    // setupCaches;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
