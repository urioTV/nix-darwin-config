{ inputs' }:
final: prev: {
  # Overlay zastępujący domyślne pakiety wersjami z llm-agents.nix
  opencode = inputs'.llm-agents.packages.opencode;
}
