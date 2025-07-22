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

    # lix-module = {
    #   # url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
    #   url = "git+https://git.lix.systems/lix-project/nixos-module?ref=release-2.93";
    #   # url = "git+https://git.lix.systems/lix-project/nixos-module?ref=main";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
      # lix-module,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      commonNixConfig = {
        nixpkgs.hostPlatform = system;
        nixpkgs.config.allowUnfree = true;
        nix.settings.experimental-features = "nix-command flakes";
        nix.enable = true;
      };
    in
    {
      darwinConfigurations."MacBook-Air-Urio" = nix-darwin.lib.darwinSystem {
        system = system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          # lix-module.nixosModules.default
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
