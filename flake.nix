{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

    ncro = {
      url = "github:feel-co/ncro";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    { ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        machineConfiguration =
          machineConfigPath:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs system; };
            modules = [
              inputs.home-manager.nixosModules.home-manager
              inputs.disko.nixosModules.disko
              inputs.grub2-themes.nixosModules.default
              inputs.nix-minecraft.nixosModules.minecraft-servers
              inputs.ncro.nixosModules.default
              (inputs.import-tree ./configuration)
            ]
            ++ [ machineConfigPath ];
          };
      in
      {
        nixosConfigurations.mainpc = machineConfiguration ./machines/mainpc.nix;
        nixosConfigurations.lenovo = machineConfiguration ./machines/lenovo.nix;
      }
    );
}
