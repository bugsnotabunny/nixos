{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixified-ai = {
      url = "github:mdietrich16/nixified-ai";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # TODO: switch to Infinidoge/nix-minecraft
    # when https://github.com/Infinidoge/nix-minecraft/pull/161
    # is accepted
    nix-minecraft.url = "github:juliamertz/nix-minecraft";
  };

  outputs = { ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystemPassThrough (system:
      let
        defaultModules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.disko.nixosModules.disko
          inputs.grub2-themes.nixosModules.default
          inputs.nix-minecraft.nixosModules.minecraft-servers

          ./configuration
        ];
        defaultSpecialArgs = { inherit inputs system; };
      in {
        nixosConfigurations.mainpc = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./machines/mainpc.nix ];
        };
        nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./machines/thinkpad.nix ];
        };
        nixosConfigurations.aspire = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./machines/acer-aspire-laptop.nix ];
        };
      });
}
