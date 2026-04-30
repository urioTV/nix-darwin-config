{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Node.js i TypeScript
    nodejs
    typescript-language-server
    typescript
    vtsls

    # Rust
    rustc
    cargo

    # Bun (runtime JS/TS)
    bun

    # Git
    gh
  ];
}
