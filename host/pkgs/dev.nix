{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Node.js i TypeScript
    nodejs
    nodePackages.typescript-language-server
    nodePackages.typescript

    # Rust
    rustc
    cargo

    # Bun (runtime JS/TS)
    bun

    # Git
    gh
  ];
}
