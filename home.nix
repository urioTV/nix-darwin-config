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

  xdg.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "micro";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
