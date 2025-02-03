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
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.activation = {
    resetLaunchPad = lib.hm.dag.entryAfter [ "installPackages" ] ''
      echo "Restarting Dock to refresh Launchpad..."
      run /usr/bin/killall Dock
    '';
  };

  xdg.enable = true;


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "micro";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
}
