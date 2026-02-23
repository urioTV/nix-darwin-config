{ inputs, ... }:
let
  sharedStylixConfig =
    { pkgs, ... }:
    {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        image = ./media/kosciejo.png;
        polarity = "dark";
      };
    };
in
{
  flake.darwinModules.stylix-config = {
    imports = [
      sharedStylixConfig
      inputs.stylix.darwinModules.stylix
    ];
  };

  flake.homeModules.stylix-config = {
    imports = [
      sharedStylixConfig
    ];
    # home-manager-specific stylix overrides
  };
}
