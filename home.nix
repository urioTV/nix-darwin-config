{
  config,
  pkgs,
  inputs,
  import-tree,
  lib,
  ...
}:

{
  flake.darwinModules.home-urio =
    {
      self,
      inputs,
      inputs',
      import-tree,
      lib,
      ...
    }:
    {
      imports = [
        inputs.home-manager.darwinModules.home-manager
      ];
      home-manager = {
        # useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backupnix";
        extraSpecialArgs = {
          inherit
            self
            inputs
            import-tree
            inputs'
            ;
        };
        sharedModules = [
          self.homeModules.sops-config
          self.homeModules.stylix-config
          self.homeModules.nix-config
          self.homeModules.ai
        ];
        users.urio = {
          imports = [ self.homeModules.home-urio ];
        };
      };
    };

  flake.homeModules.home-urio =
    {
      config,
      lib,
      pkgs,
      import-tree,
      ...
    }:
    {

      imports = (import-tree ./home).imports;

      home.activation = {
        resetLaunchPad = lib.hm.dag.entryAfter [ "installPackages" ] ''
          echo "Restarting Dock to refresh Launchpad..."
          run /usr/bin/killall Dock
        '';
      };

      home.file = {
        ".config/zed" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-darwin-config/dotfiles/zed";
        };
        "Library/Application Support/Antigravity/User/settings.json" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-darwin-config/dotfiles/antigravity/settings.json";
        };
      };

      xdg.enable = true;

      home.stateVersion = "23.11";

      home.username = "urio";
      home.homeDirectory = "/Users/urio";

      home.sessionVariables = {
        EDITOR = "micro";
        DBX_CONTAINER_HOME_PREFIX = "$HOME/distrobox";
      };

      home.sessionPath = [
        "$HOME/.local/bin"
      ];
    };
}
