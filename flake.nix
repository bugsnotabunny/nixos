{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = { url = "github:vinceliuice/grub2-themes"; };
    battery-notifier = {
      url = "github:luisnquin/battery-notifier";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { battery-notifier, nixpkgs, home-manager, grub2-themes, disko, ... }: {
      system = "x86_64-linux";
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          grub2-themes.nixosModules.default
          battery-notifier.homeManagerModule.default
          ./configuration.nix

          # local/default.nix is effectively a symlink
          # to needed machine-specific config.
          # for example, it may consist of the following line
          # import mainpc.nix
          ./local
        ];
      };
    };
}
