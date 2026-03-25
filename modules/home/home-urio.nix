{ self, inputs, ... }:
{
  flake.darwinModules.home-urio =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.darwinModules.home-manager
      ];

      system.primaryUser = "urio";

      users.users.urio = {
        name = "urio";
        home = "/Users/urio";
      };

      home-manager = {
        useUserPackages = true;
        backupFileExtension = "backupnix";
        extraSpecialArgs = { inherit inputs self; };
        sharedModules = [
          self.homeModules.sops-config
          self.homeModules.stylix-config
          self.homeModules.nix-overlay
        ];
        users.urio =
          {
            config,
            pkgs,
            lib,
            ...
          }:
          {
            imports = [
              self.homeModules.shells
              self.homeModules.misc
              self.homeModules.gui-apps
              self.homeModules.ai
            ];

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
      };
    };
}
