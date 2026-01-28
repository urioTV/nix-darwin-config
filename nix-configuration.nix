{ pkgs, system, ... }:
{
  # nix.optimise = {
  #   automatic = true;
  #   interval = {
  #     Weekday = 0;
  #     Hour = 0;
  #     Minute = 0;
  #   };
  # };

  # nix.gc = {
  #   automatic = true;
  #   interval = {
  #     Weekday = 0;
  #     Hour = 0;
  #     Minute = 0;
  #   };
  #   options = "--delete-older-than 3d";
  # };

  nixpkgs.hostPlatform = system;
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;

    # Determinate Nix Specific
    eval-cores = 0;

    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "urio"
    ];
  };
  nix.enable = false;

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     inherit (prev.lixPackageSets.stable)
  #       nixpkgs-review
  #       nix-eval-jobs
  #       nix-fast-build
  #       colmena
  #       ;
  #   })
  # ];

  # nix.package = pkgs.lixPackageSets.stable.lix;
}
