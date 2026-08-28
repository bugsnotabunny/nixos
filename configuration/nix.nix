{ config, ... }:
let
  cachesList = [
    {
      sub = "https://cache.nixos.org";
      key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    }
    {
      sub = "https://attic.xuyh0120.win/lantian";
      key = "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=";
    }
    {
      sub = "https://cache.xinux.uz";
      key = "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=";
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
