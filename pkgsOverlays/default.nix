self: super: {
  ktalk = super.callPackage ./ktalk.nix { };
  pokemon-trainer = super.callPackage ./pokemon-trainer.nix { };
  stable-diffusion10 = super.callPackage ./stable-diffusion10.nix { };
}
