{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    zen-browser = {
      url = "github:Axot017/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes.url = "github:vinceliuice/grub2-themes";
    flake-utils.url = "github:numtide/flake-utils";
    nix-alien.url = "github:thiagokokada/nix-alien";

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

          ./gaming
          ./home
          ./disko
          ./system
        ];
        defaultSpecialArgs = { inherit inputs system; };
      in {
        nixosConfigurations.mainpc = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./local/mainpc.nix ];
        };
        nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./local/thinkpad.nix ];
        };
        nixosConfigurations.aspire = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = defaultSpecialArgs;
          modules = defaultModules ++ [ ./local/acer-aspire-laptop.nix ];
        };
      });
}
