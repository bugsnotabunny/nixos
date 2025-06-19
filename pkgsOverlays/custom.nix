lib:
(final: prev:
  let dir = ./custom;
  in {
    custom = builtins.listToAttrs (builtins.map (file:
      let
        fileFull = dir + "/${file}";
        fileTrimmed = lib.strings.removeSuffix ".nix" file;
        package = prev.callPackage fileFull { };
      in {
        name = fileTrimmed;
        value = package;
      }) (builtins.attrNames (builtins.readDir dir)));
  })
