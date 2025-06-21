lib:
(self: super: {
  custom = lib.filesystem.packagesFromDirectoryRecursive {
    inherit (self) callPackage;
    directory = ./custom;
  };
})
