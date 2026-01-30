{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./pkgs.nix
    ./fonts.nix
    ./java-jdk.nix
    ./programs
    ./sops.nix
  ];
}
