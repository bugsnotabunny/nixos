{ config,  lib, ... }: {
  options = {
    rootDevice = with lib; mkOption { type = types.str; };
    storageDevices = with lib; mkOption {type = types.listOf types.str;};
  };
  
  config = import ./disko.nix {rootDevice = config.rootDevice; storageDevices = config.storageDevices; };
}
