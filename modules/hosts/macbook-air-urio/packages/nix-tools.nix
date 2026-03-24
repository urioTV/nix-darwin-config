{ self, inputs, ... }:
{
  flake.darwinModules.nix-tools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Nix formatter (RFC style)
        nixfmt

        # Nix language server (LSP)
        nixd
      ];
    };
}
