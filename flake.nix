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
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      system = "x86_64-linux";
      defaultModules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        inputs.grub2-themes.nixosModules.default
        {
          environment.systemPackages =
            [ inputs.zen-browser.packages."${system}".default ];
        }

        ./home
        ./disko
        ./system
      ];
    in {
      inherit system;
      nixosConfigurations.mainpc = inputs.nixpkgs.lib.nixosSystem {
        modules = defaultModules ++ [ ./local/mainpc.nix ];
      };
      nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
        modules = defaultModules ++ [ ./local/thinkpad.nix ];
      };
      nixosConfigurations.aspire = inputs.nixpkgs.lib.nixosSystem {
        modules = defaultModules ++ [ ./local/acer-aspire-laptop.nix ];
      };
    };
}
