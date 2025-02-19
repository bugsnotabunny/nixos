self: super: {
  ktalk = super.callPackage ./ktalk.nix { };
  battery-notify = super.callPackage ./battery-notify.nix { };
}

