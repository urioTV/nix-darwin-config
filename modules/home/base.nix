{ self, inputs, ... }:
{
  flake.homeModules.base =
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

      home.packages = [
        pkgs.fastfetch
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
}
