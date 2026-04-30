{ config, pkgs, ... }:
{
  xdg.configFile."opencode/oh-my-opencode-slim.json".text = builtins.toJSON {
    fallback = {
      enabled = false;
      chains = {
        oracle = [
          "opencode-go/kimi-k2.5"
        ];
        designer = [
          "opencode-go/kimi-k2.5"
        ];
        fixer = [
          "opencode-go/minimax-m2.7"
          "github-copilot/gpt-5-mini"
          "openrouter/x-ai/grok-4.1-fast"
        ];
      };
    };

    agents = {
      orchestrator = {
        model = "opencode-go/glm-5.1";
      };
      oracle = {
        model = "opencode-go/kimi-k2.5";
      };
      explorer = {
        model = "opencode-go/minimax-m2.7";
      };
      librarian = {
        model = "opencode-go/minimax-m2.7";
      };
      designer = {
        model = "opencode-go/kimi-k2.5";
      };
      fixer = {
        model = "opencode-go/minimax-m2.7";
      };
    };
  };
}
