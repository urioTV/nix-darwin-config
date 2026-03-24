{ self, inputs, ... }:
{
  flake.darwinModules.nix-tools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Formatter Nixa (styl RFC)
        nixfmt

        # Serwer języka Nix (LSP)
        nixd
      ];
    };
}
