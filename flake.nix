{
  description = "nix-darwin configuration — MacBook-Air-Urio (aarch64-darwin)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree = {
      url = "github:vic/import-tree";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      import-tree,
      self,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          ./libs/darwin-flake-module.nix
          ./sops-config.nix
          ./stylix-config.nix
        ];

        systems = [ "aarch64-darwin" ];

        flake.darwinConfigurations.MacBook-Air-Urio = inputs.nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs import-tree self;
            system = "aarch64-darwin";
          };
          modules = [
            ./configuration.nix
            ./nix-configuration.nix
            self.darwinModules.sops-config
            inputs.home-manager.darwinModules.home-manager
            self.darwinModules.stylix-config
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backupnix";
                extraSpecialArgs = {
                  inherit inputs import-tree;
                };
                sharedModules = [
                  self.homeModules.sops-config
                  self.homeModules.stylix-config
                ];
                users.urio = import ./home.nix;
              };
            }
          ];
        };
      }
    );
}
