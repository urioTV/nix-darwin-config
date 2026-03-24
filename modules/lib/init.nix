# Moduł inicjalizujący opcje flake-parts dla darwin i home-manager
{ lib, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  # Definicja opcji flake.darwinModules
  options.flake.darwinModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Darwin modules exported by this flake, mergeable across multiple flake-parts modules.";
  };

  config = {
    systems = [ "aarch64-darwin" ];
  };
}
