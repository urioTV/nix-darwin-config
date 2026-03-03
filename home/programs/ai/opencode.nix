{ config, pkgs, ... }:
{
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON {
    google_auth = false;
    runtime_fallback = {
      enabled = true;
      retry_on_errors = [
        400
        401
        402
        403
        404
        429
        500
        503
        529
      ];
      max_fallback_attempts = 5;
      cooldown_seconds = 60;
      timeout_seconds = 10;
      notify_on_fallback = true;
    };

    agents = {
      # --- Z.ai Coding Plan Agents ---
      sisyphus = {
        model = "zai-coding-plan/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "nano-gpt/qwen/qwen3.5-397b-a17b"
        ];
      };
      metis = {
        model = "google/gemini-3.1-pro-preview";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "zai-coding-plan/glm-4.7"
          "nano-gpt/qwen/qwen3.5-397b-a17b-thinking"
        ];
      };

      # --- Dual-Prompt Agents ---
      prometheus = {
        model = "zai-coding-plan/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "nano-gpt/qwen/qwen3.5-397b-a17b-thinking"
        ];
      };
      atlas = {
        model = "zai-coding-plan/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "nano-gpt/qwen/qwen3.5-397b-a17b-thinking"
        ];
      };

      # --- GPT-Native Agents (GPT family only) ---
      hephaestus = {
        model = "github-copilot/gpt-5.2-codex";
        fallback_models = [ "github-copilot/gpt-5-mini" ];
      };
      oracle = {
        model = "github-copilot/gpt-5.1-codex-mini";
        fallback_models = [ "github-copilot/gpt-5-mini" ];
      };
      momus = {
        model = "github-copilot/gpt-5.1-codex-mini";
        fallback_models = [ "github-copilot/gpt-5-mini" ];
      };

      # --- Utility / Subagents (Speed and cost focused) ---
      "sisyphus-junior" = {
        model = "nano-gpt/qwen3.5-122b-a10b";
      };
      explore = {
        model = "nano-gpt/qwen3.5-122b-a10b";
      };
      librarian = {
        model = "nano-gpt/qwen3.5-122b-a10b";
      };
      "multimodal-looker" = {
        model = "google/gemini-3-flash-preview";
      };
    };
  };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      provider = {
        openrouter = {
          options = {
            # baseURL = "https://openrouter.ai/api/v1";
            apiKey = "{file:${config.sops.secrets.openrouter_api_key.path}}";
          };
        };
        nano-gpt = {
          models = {
            "qwen3.5-35b-a3b" = {
              name = "Qwen3.5 35B";
            };
            "qwen3.5-35b-a3b:thinking" = {
              name = "Qwen3.5 35B Thinking";
            };
            "qwen3.5-122b-a10b" = {
              name = "Qwen3.5 122B";
            };
            "qwen3.5-122b-a10b:thinking" = {
              name = "Qwen3.5 122B Thinking";
            };
          };
          options = {
            apiKey = "{file:${config.sops.secrets.nano-gpt_api_key.path}}";
          };
        };
      };
      plugin = [
        "opencode-gemini-auth@latest"
        "@tarquinen/opencode-dcp@latest"
        "@simonwjackson/opencode-direnv"
        "oh-my-opencode"
      ];
    };
  };

}
