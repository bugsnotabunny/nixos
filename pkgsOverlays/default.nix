self: super: {
  ktalk = super.callPackage ./ktalk.nix { };
  myllms = super.callPackage ./myllms.nix { };
}
