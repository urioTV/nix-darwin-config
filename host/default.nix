{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./pkgs.nix
    ./homebrew.nix
    ./fonts.nix
    ./java-jdk.nix
    ./programs
  ];
}
