{
  pkgs,
  self,
  lib,
  import-tree,
  ...
}:
{
  imports = [
    (import-tree ./host)
    ./homebrew.nix
  ];
  system.primaryUser = "urio";

  users.users.urio = {
    name = "urio";
    home = "/Users/urio";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  security.sudo.extraConfig = ''
    Defaults always_set_home
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = false;
  system.defaults.finder.AppleShowAllFiles = false;
}
