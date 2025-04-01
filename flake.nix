{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.769969";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module?ref=release-2.92";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      lix-module,
      ...
    }@inputs:
    {
      darwinConfigurations."MacBook-Air-Urio" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          lix-module.nixosModules.default
          ./configuration.nix
          {
            # The platform the configuration will be used on.
            nixpkgs.hostPlatform = "aarch64-darwin";

            # Auto upgrade nix package and the daemon service.
            # services.nix-daemon.enable = true;
            nix.enable = true;
            # nix.package = pkgs.nix;

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            nixpkgs.config.allowUnfree = true;
            system.configurationRevision = self.rev or self.dirtyRev or null;

          }
          home-manager.darwinModules.home-manager
          {
            users.users.urio = {
              name = "urio";
              home = "/Users/urio";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backupnix";
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.sharedModules = [

            ];
            home-manager.users.urio = {
              imports = [ ./home.nix ];
            };
            home-manager.users.urio.home.username = "urio";
            home-manager.users.urio.home.homeDirectory = "/Users/urio";
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."MacBook-Air-Konrad".pkgs;
    };
}
