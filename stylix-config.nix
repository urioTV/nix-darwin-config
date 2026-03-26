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
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font Mono";
          };
          sansSerif = {
            package = pkgs.inter-nerdfont;
            name = "Inter Nerd Font";
          };
          serif = {
            package = pkgs.inter-nerdfont;
            name = "Inter Nerd Font";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };
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
