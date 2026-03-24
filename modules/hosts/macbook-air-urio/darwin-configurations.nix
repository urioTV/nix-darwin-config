{ self, inputs, ... }:
{
  flake.darwinConfigurations.MacBook-Air-Urio = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs self; };
    modules = [
      self.darwinModules.macbook-air-urio-configuration
      self.darwinModules.nix-config
      self.darwinModules.nix-overlay
      self.darwinModules.sops-config
      inputs.home-manager.darwinModules.home-manager
      self.darwinModules.stylix-config
      {
        home-manager = {
          useUserPackages = true;
          backupFileExtension = "backupnix";
          extraSpecialArgs = { inherit inputs self; };
          sharedModules = [
            self.homeModules.sops-config
            self.homeModules.stylix-config
            self.homeModules.nix-overlay
          ];
          users.urio = self.homeModules.base;
        };
      }
    ];
  };
}
