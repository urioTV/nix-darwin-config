{
  inputs,
  import-tree,
  ...
}:
{
  flake.darwinConfigurations.MacBook-Air-Urio = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = {
      inherit inputs import-tree;
    };
    modules = [
      ./configuration.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backupnix";
          extraSpecialArgs = {
            inherit inputs import-tree;
          };
          users.urio = import ./home.nix;
        };
      }
    ];
  };
}
