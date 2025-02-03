{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./shells.nix
  ];
  programs = {
    git = {
      enable = true;
      userEmail = "uriootv@protonmail.com";
      userName = "urioTV";
    };
    bat = {
      enable = true;
    };
    bun = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
