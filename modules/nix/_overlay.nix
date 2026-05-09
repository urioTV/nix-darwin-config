{ inputs' }:
final: prev: {
  # Overlay z llm-agents.nix dla PI coding agent
  llm-agents = {
    pi = inputs'.llm-agents.packages.pi;
    opencode = inputs'.llm-agents.packages.opencode;
  };

  opencode = inputs'.llm-agents.packages.opencode;
}
