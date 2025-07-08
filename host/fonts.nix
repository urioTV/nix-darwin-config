{
  pkgs,
  config,
  inputs,
  ...
}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerd-fonts.hack
    nerd-fonts.open-dyslexic
    jetbrains-mono
    font-awesome
    ubuntu_font_family
    baekmuk-ttf
    nerd-font-patcher
    corefonts
    open-sans
    # inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
    # inputs.apple-fonts.packages.${pkgs.system}.sf-compact-nerd
    # inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
    # inputs.apple-fonts.packages.${pkgs.system}.ny-nerd
  ];
}
