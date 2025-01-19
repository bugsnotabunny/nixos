{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, disko, ... }: {
    system = "x86_64-linux";
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        ./local.nix
        ./configuration.nix
      ];
    };

  };
}
