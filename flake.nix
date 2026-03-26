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
          (import-tree ./modules)
          (import-tree ./libs)
          ./home.nix
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
              self.darwinModules.stylix-config
              self.darwinModules.home-urio
            ];
          }
        );
      }
    );
}
