{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixified-ai.url = "github:nixified-ai/flake";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixified-ai, home-manager, disko, ... }: {
    system = "x86_64-linux";
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        nixified-ai.nixosModules.comfyui
        ./local.nix
        ./configuration.nix
      ];
    };

  };
}
