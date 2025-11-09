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
    jetbrains-mono
    font-awesome
    ubuntu-classic
    baekmuk-ttf
    nerd-font-patcher
    # corefonts
    open-sans
    inputs.apple-fonts.packages.${system}.sf-pro-nerd
    inputs.apple-fonts.packages.${system}.sf-compact-nerd
    inputs.apple-fonts.packages.${system}.sf-mono-nerd
    inputs.apple-fonts.packages.${system}.ny-nerd
  ];
}
