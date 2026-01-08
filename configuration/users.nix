{ lib, config, ... }: {
  options = with lib; {
    username = mkOption { type = types.str; };
    usernameFull = mkOption {
      type = types.str;
      default = config.username;
    };
  };

  config = {
    # Don't forget to set a password with ‘passwd’.
    users.users.${config.username} = {
      isNormalUser = true;
      description = config.usernameFull;
      extraGroups =
        [ "audio" "docker" "input" "networkmanager" "video" "wheel" ];
    };
  };
}
