{ self, inputs, ... }:
{
  flake.homeModules.gui-apps =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs = {
        ghostty = {
          enable = true;
          package = pkgs.ghostty-bin;
          enableZshIntegration = true;
          settings = {
            font-family = "JetBrainsMono Nerd Font Mono";
            font-size = 12;
            image-storage-limit = 320000000;
          };
        };
      };
    };
}
