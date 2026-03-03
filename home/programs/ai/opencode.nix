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
        model = "litellm/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "litellm/qwen3.5-397b"
        ];
      };
      metis = {
        model = "google/gemini-3.1-pro-preview";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "litellm/glm-4.7"
          "litellm/qwen3.5-397b-thinking"
        ];
      };

      # --- Dual-Prompt Agents ---
      prometheus = {
        model = "litellm/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "litellm/qwen3.5-397b-thinking"
        ];
      };
      atlas = {
        model = "litellm/glm-5";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "litellm/qwen3.5-397b-thinking"
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
        model = "litellm/qwen3.5-122b";
      };
      explore = {
        model = "litellm/qwen3.5-122b";
      };
      librarian = {
        model = "litellm/qwen3.5-122b";
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
        litellm = {
          npm = "@ai-sdk/openai-compatible";
          name = "LiteLLM";
          models = {
            "glm-5" = {
              name = "GLM-5";
            };
            "glm-4.7" = {
              name = "GLM-4.7";
            };
            "minimax-m2.5" = {
              name = "MiniMax-m2.5";
            };
            "qwen3.5-397b" = {
              name = "Qwen3.5-397b";
            };
            "qwen3.5-397b-thinking" = {
              name = "Qwen3.5-397b Thinking";
            };
            "qwen3.5-122b" = {
              name = "Qwen3.5-122b";
            };
            "qwen3.5-122b-thinking" = {
              name = "Qwen3.5-122b Thinking";
            };
            "qwen3.5-35b" = {
              name = "Qwen3.5-35b";
            };
            "qwen3.5-35b-thinking" = {
              name = "Qwen3.5-35b Thinking";
            };
            "qwen3.5-27b" = {
              name = "Qwen3.5-27b";
            };
            "qwen3.5-27b-thinking" = {
              name = "Qwen3.5-27b Thinking";
            };
          };
          options = {
            baseURL = "{file:${config.sops.secrets.litellm_base_url.path}}";
            apiKey = "{file:${config.sops.secrets.litellm_api_key.path}}";
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
