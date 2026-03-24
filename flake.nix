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

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
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
      { withSystem, ... }:
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          ./libs/darwin-flake-module.nix
          ./sops-config.nix
          ./stylix-config.nix
          ./nix-config.nix
        ];

        systems = [ "aarch64-darwin" ];

        flake.darwinConfigurations.MacBook-Air-Urio = withSystem "aarch64-darwin" (
          { system, inputs', ... }:
          inputs.nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              inherit
                inputs
                import-tree
                self
                inputs'
                ;
            };
            modules = [
              ./configuration.nix
              self.darwinModules.nix-config
              self.darwinModules.sops-config
              inputs.home-manager.darwinModules.home-manager
              self.darwinModules.stylix-config
              {
                home-manager = {
                  # useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "backupnix";
                  extraSpecialArgs = {
                    inherit inputs import-tree inputs';
                  };
                  sharedModules = [
                    self.homeModules.sops-config
                    self.homeModules.stylix-config
                    self.homeModules.nix-config
                  ];
                  users.urio = import ./home.nix;
                };
              }
            ];
          }
        );
      }
    );
}
