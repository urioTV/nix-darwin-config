{
  pkgs,
  self,
  lib,
  ...
}:
{
  imports = [
    ./host
    ./homebrew.nix
  ];
  system.primaryUser = "urio";

  security.pam.services.sudo_local.touchIdAuth = true;

  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
  };

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 3d";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = false;
  system.defaults.finder.AppleShowAllFiles = false;
}
