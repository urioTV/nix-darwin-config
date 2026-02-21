{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Formatter Nixa (styl RFC)
    nixfmt-rfc-style

    # Serwer języka Nix (LSP)
    nixd
  ];
}
