{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [ ./home ];

  # nix.package = pkgs.nix;
  # nixpkgs.config.allowUnfree = true;

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
  };

  xdg.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "micro";
    DBX_CONTAINER_HOME_PREFIX = "$HOME/distrobox";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
