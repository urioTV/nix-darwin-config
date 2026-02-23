{ ... }:
{
  flake.darwinModules.nix-config = {
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
    };
  };

  flake.homeModules.nix-config = {
    # home-manager-specific nix configuration
  };
}
