{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # TODO FIX HOME-MANAGER
          # home-manager.lib.homeManagerConfiguration {
          #   home.username = "xaxa";
          #   home.homeDirectory = "/home/xaxa";
          #   modules = [ ./home.nix ];
          # }
        ];
      };
    };
  };
}
