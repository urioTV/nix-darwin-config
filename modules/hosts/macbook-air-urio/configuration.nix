{ self, inputs, ... }:
{
  flake.darwinModules.macbook-air-urio-configuration =
    {
      pkgs,
      self,
      lib,
      ...
    }:
    {
      imports = [
        self.darwinModules.homebrew
        self.darwinModules.fonts
        self.darwinModules.java-jdk
        self.darwinModules.system-packages
        self.darwinModules.dev-packages
        self.darwinModules.devops-packages
        self.darwinModules.nix-tools
        self.darwinModules.secrets-packages
      ];

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
    };
}
