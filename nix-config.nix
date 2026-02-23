{ ... }:
let
  sharedNixConfig =
    { ... }:
    {
      nixpkgs.config.allowUnfree = true;
    };
in
{
  flake.darwinModules.nix-config = {
    imports = [ sharedNixConfig ];

    # darwin-specific nix configuration
    nixpkgs.hostPlatform = "aarch64-darwin";
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
    };
  };

  flake.homeModules.nix-config = {
    imports = [ sharedNixConfig ];

    # home-manager-specific nix configuration
  };
}
