# flake-parts initialization module for darwin and home-manager
{ lib, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  # Define flake.darwinModules option
  options.flake.darwinModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Darwin modules exported by this flake, mergeable across multiple flake-parts modules.";
  };

  config = {
    systems = [ "aarch64-darwin" ];
  };
}
