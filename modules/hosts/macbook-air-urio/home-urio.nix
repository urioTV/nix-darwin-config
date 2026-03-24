{ self, inputs, ... }:
{
  flake.darwinModules.home-urio =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.darwinModules.home-manager
      ];

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
    };
}
