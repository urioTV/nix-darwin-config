{ inputs, ... }:
{
  flake.darwinModules.nix-overlay =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          opencode = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
        })
      ];
    };

  flake.homeModules.nix-overlay =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          opencode = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
        })
      ];
    };
}
