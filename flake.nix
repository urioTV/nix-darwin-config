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
      commonNixConfig =
        { pkgs, ... }:
        {
          nixpkgs.hostPlatform = system;
          nixpkgs.config.allowUnfree = true;
          nix.settings.experimental-features = "nix-command flakes";
          nix.enable = true;

          nixpkgs.overlays = [
            (final: prev: {
              inherit (prev.lixPackageSets.stable)
                nixpkgs-review
                nix-eval-jobs
                nix-fast-build
                colmena
                ;
            })
          ];

          nix.package = pkgs.lixPackageSets.stable.lix;
        };
    in
    {
      darwinConfigurations."MacBook-Air-Urio" = nix-darwin.lib.darwinSystem {
        system = system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          commonNixConfig
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
      darwinPackages = self.darwinConfigurations."MacBook-Air-Urio".pkgs;
    };
}
