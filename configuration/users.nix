{ lib, config, ... }: {
  options = with lib; {
    username = mkOption { type = types.str; };
    userDescription = mkOption {
      type = types.str;
      default = config.username;
    };
    userEmail = mkOption {
      type = types.str;
      default = "malakhov.malakhit@gmail.com";
    };
  };

  config = {
    # Don't forget to set a password with ‘passwd’.
    users.users.${config.username} = {
      isNormalUser = true;
      description = config.userDescription;
      extraGroups =
        [ "audio" "docker" "input" "networkmanager" "video" "wheel" ];
    };
  };
}
