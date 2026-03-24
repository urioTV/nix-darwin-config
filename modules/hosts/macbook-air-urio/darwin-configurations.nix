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
      self.darwinModules.stylix-config
      self.darwinModules.home-urio
    ];
  };
}
