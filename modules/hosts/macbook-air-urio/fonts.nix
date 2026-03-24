{ self, inputs, ... }:
{
  flake.darwinModules.fonts =
    {
      pkgs,
      config,
      inputs,
      system,
      ...
    }:
    {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        nerd-fonts.hack
        nerd-fonts.open-dyslexic
        nerd-fonts.jetbrains-mono
        font-awesome
        ubuntu-classic
        baekmuk-ttf
        nerd-font-patcher
        # corefonts
        open-sans
        inter-nerdfont
      ];
    };
}
