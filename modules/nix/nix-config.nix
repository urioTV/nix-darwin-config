{ inputs, ... }:
let
  sharedConfig =
    { inputs', ... }:
    {
      nixpkgs.overlays = [
        (import ./_overlay.nix { inherit inputs'; })
      ];
    };
in
{
  flake.darwinModules.nix-config =
    {
      pkgs,
      lib,
      inputs,
      inputs',
      ...
    }:
    {
      imports = [ (sharedConfig { inherit inputs'; }) ];

      # darwin-specific nix configuration
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
      nix.enable = false;
      nix.settings = {
        auto-optimise-store = true;

        # Determinate Nix specific
        eval-cores = 0;

        experimental-features = "nix-command flakes";
        trusted-users = [
          "root"
          "urio"
        ];

        # Numtide binary cache for llm-agents
        substituters = [
          "https://cache.nixos.org"
          "https://cache.numtide.com"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };
    };

  flake.homeModules.nix-config =
    {
      pkgs,
      lib,
      inputs,
      inputs',
      ...
    }:
    {
      imports = [ (sharedConfig { inherit inputs'; }) ];
    };
}
