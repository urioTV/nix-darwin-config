{
  description = "Example Darwin system flake";

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
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      hostname = "MacBook-Air-Urio";
    in
    {
      darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
        system = system;
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          ./configuration.nix
          ./nix-configuration.nix
          inputs.sops-nix.darwinModules.sops
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backupnix";
              extraSpecialArgs = {
                inherit inputs;
              };
              sharedModules = [

              ];
              users.urio = {
                imports = [ ./home.nix ];
                home.username = "urio";
                home.homeDirectory = "/Users/urio";
              };
            };
            users.users.urio = {
              name = "urio";
              home = "/Users/urio";
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
    };
}
