{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    
    wallpaper = {
      url = "path:/etc/nixos/hosts/default/wallpaper.jpg"; 
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-stable, home-manager, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      stable = import nix-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit stable; 
        };
        modules = [
          ./hosts/default/configuration.nix
          stylix.nixosModules.stylix
          {
            _module.args.stable = stable;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit stable; };
            home-manager.users.xaxa = import ./hosts/default/home.nix;
          }
        ];
      };
    };
}