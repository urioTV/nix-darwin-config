{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "uriootv@protonmail.com";
          name = "urioTV";
        };
      };
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
    uv = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
