{ inputs, ... }:
{
  flake.darwinModules.nix-config =
    { pkgs, ... }:
    {
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
      nix.enable = false;
      nix.settings = {
        auto-optimise-store = true;
        eval-cores = 0;
        experimental-features = "nix-command flakes";
        trusted-users = [
          "root"
          "urio"
        ];
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
}
