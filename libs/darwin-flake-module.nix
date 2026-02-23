# Flake-parts module that declares `flake.darwinModules` as a mergeable
# lazyAttrsOf option — analogous to what home-manager provides for
# `flake.homeModules` via inputs.home-manager.flakeModules.home-manager.
#
# Usage in flake.nix:
#   imports = [
#     ./libs/darwin-flake-module.nix
#     ./sops-config.nix
#     ./stylix-config.nix
#   ];
{ lib, ... }:
{
  options.flake.darwinModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Darwin modules exported by this flake, mergeable across multiple flake-parts modules.";
  };
}
