{
  description = "System config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs { 
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      JavadDenFemte = nixpkgs.lib.nixosSystem {
        modules = [ 
          ./system
          ./modules
          ./configuration.nix 
        ];

        specialArgs = { 
          inherit inputs; 
        };
      };
    };
  };
}