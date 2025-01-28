{ lib, ... }: {
  options.rootDevice = with lib; mkOption { type = types.str; };
  imports = [ ./disko.nix ];
}
