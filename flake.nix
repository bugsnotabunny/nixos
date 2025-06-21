{
  description = "A very basic flake";

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
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    flake-utils.url = "github:numtide/flake-utils";
    zen-browser = {
      url = "github:Axot017/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystemPassThrough (system:
      let
        defaultModules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.disko.nixosModules.disko
          inputs.grub2-themes.nixosModules.default

          ({ config, lib, ... }: {
            options.cpuArch = lib.mkOption {
              type = lib.types.str;
              default = "default";
            };
            config = let
            in {
              nixpkgs.overlays = let
              in [
                # inputs.nix-comfyui.overlays.default
                inputs.nixified-ai.overlays.comfyui
                (import ./pkgsOverlays/custom.nix lib)
                (import ./pkgsOverlays/optimized.nix config.cpuArch)
              ];
              environment.systemPackages =
                [ inputs.zen-browser.packages."${system}".default ];
            };
          })

          ./home
          ./disko
          ./system
        ];
      in {
        nixosConfigurations.mainpc = inputs.nixpkgs.lib.nixosSystem {
          modules = defaultModules ++ [ ./local/mainpc.nix ];
        };
        nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
          modules = defaultModules ++ [ ./local/thinkpad.nix ];
        };
        nixosConfigurations.aspire = inputs.nixpkgs.lib.nixosSystem {
          modules = defaultModules ++ [ ./local/acer-aspire-laptop.nix ];
        };
      });
}
