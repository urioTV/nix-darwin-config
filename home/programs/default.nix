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
    nh = {
      enable = true;
      # clean.enable = true;
      # clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/Users/urio/nix-darwin-config";
    };
    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
