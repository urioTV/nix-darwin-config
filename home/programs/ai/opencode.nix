{ config, pkgs, ... }:
let
  commonModels = {
    model = "zai-coding-plan/glm-5";
    fallback_models = [
      "github-copilot/claude-sonnet-4.6"
      "nano-gpt/qwen3.5-122b-a10b:thinking"
      "openrouter/zhipuai/glm-5"
    ];
  };

  gptModels = {
    model = "openrouter/openai/gpt-5.1-codex-mini";
    fallback_models = [ "github-copilot/gpt-5-mini" ];
  };

  miniModels = {
    model = "github-copilot/gpt-5-mini";
  };
in
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
      sisyphus = commonModels;
      metis = {
        model = "google/gemini-3.1-pro-preview";
        fallback_models = [
          "github-copilot/claude-sonnet-4.6"
          "zai-coding-plan/glm-5"
          "nano-gpt/qwen3.5-122b-a10b:thinking"
        ];
      };

      # --- Dual-Prompt Agents ---
      prometheus = commonModels;
      atlas = commonModels;

      # --- GPT-Native Agents (GPT family only) ---
      hephaestus = gptModels;
      oracle = gptModels;
      momus = gptModels;

      # --- Utility / Subagents (Speed and cost focused) ---
      "sisyphus-junior" = miniModels;
      explore = miniModels;
      librarian = miniModels;
      "multimodal-looker" = miniModels;
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
        ramalama = {
          npm = "@ai-sdk/openai-compatible";
          name = "RamaLama (Local)";
          options = {
            baseURL = "http://127.0.0.1:8080/v1";
            apiKey = "";
          };
          models = {
            "unsloth/GLM-4.6V-Flash-GGUF:Q6_K" = {
              name = "GLM-4.6V Flash";
            };
            "TeichAI/Qwen3-14B-Claude-4.5-Opus-High-Reasoning-Distill-GGUF:Q4_K_M" = {
              name = "Qwen3-14B Claude 4.5 Opus Distill";
            };
          };
        };
        litellm = {
          npm = "@ai-sdk/openai-compatible";
          name = "LiteLLM Proxy";
          options = {
            baseURL = "https://litellm.urio.dev/v1";
            apiKey = "{file:${config.sops.secrets.litellm_api_key.path}}";
          };
          models = {
            # GLM Family
            "glm-5" = {
              name = "GLM-5";
            };
            "glm-5-nano" = {
              name = "GLM-5 Nano";
            };
            "glm-5-openrouter" = {
              name = "GLM-5 (OpenRouter)";
            };
            "glm-4.7" = {
              name = "GLM-4.7";
            };
            "glm-4.7-nano" = {
              name = "GLM-4.7 Nano";
            };
            "glm-4.7-openrouter" = {
              name = "GLM-4.7 (OpenRouter)";
            };
            # Qwen Family
            "qwen3.5-397b" = {
              name = "Qwen3.5 397B";
            };
            "qwen3.5-397b-openrouter" = {
              name = "Qwen3.5 397B (OpenRouter)";
            };
            "qwen3.5-397b-thinking" = {
              name = "Qwen3.5 397B Thinking";
            };
            "qwen3.5-397b-thinking-openrouter" = {
              name = "Qwen3.5 397B Thinking (OpenRouter)";
            };
            "qwen3.5-122b" = {
              name = "Qwen3.5 122B";
            };
            "qwen3.5-122b-openrouter" = {
              name = "Qwen3.5 122B (OpenRouter)";
            };
            "qwen3.5-122b-thinking" = {
              name = "Qwen3.5 122B Thinking";
            };
            "qwen3.5-122b-thinking-openrouter" = {
              name = "Qwen3.5 122B Thinking (OpenRouter)";
            };
            "qwen3.5-35b" = {
              name = "Qwen3.5 35B";
            };
            "qwen3.5-35b-openrouter" = {
              name = "Qwen3.5 35B (OpenRouter)";
            };
            "qwen3.5-35b-thinking" = {
              name = "Qwen3.5 35B Thinking";
            };
            "qwen3.5-35b-thinking-openrouter" = {
              name = "Qwen3.5 35B Thinking (OpenRouter)";
            };
            "qwen3.5-27b" = {
              name = "Qwen3.5 27B";
            };
            "qwen3.5-27b-openrouter" = {
              name = "Qwen3.5 27B (OpenRouter)";
            };
            "qwen3.5-27b-thinking" = {
              name = "Qwen3.5 27B Thinking";
            };
            "qwen3.5-27b-thinking-openrouter" = {
              name = "Qwen3.5 27B Thinking (OpenRouter)";
            };
            # MiniMax
            "minimax-m2.5" = {
              name = "MiniMax M2.5";
            };
            "minimax-m2.5-openrouter" = {
              name = "MiniMax M2.5 (OpenRouter)";
            };
            # Claude Family (via GitHub Copilot)
            "claude-opus-4.6" = {
              name = "Claude Opus 4.6";
            };
            "claude-opus-4.6-fast" = {
              name = "Claude Opus 4.6 Fast";
            };
            "claude-sonnet-4.6" = {
              name = "Claude Sonnet 4.6";
            };
            "claude-haiku-4.5" = {
              name = "Claude Haiku 4.5";
            };
            # GPT-5 Family (via GitHub Copilot)
            "gpt-5.4" = {
              name = "GPT-5.4";
            };
            "gpt-5.3-codex" = {
              name = "GPT-5.3 Codex";
            };
            "gpt-5.2" = {
              name = "GPT-5.2";
            };
            "gpt-5.2-codex" = {
              name = "GPT-5.2 Codex";
            };
            "gpt-5.1" = {
              name = "GPT-5.1";
            };
            "gpt-5.1-codex" = {
              name = "GPT-5.1 Codex";
            };
            "gpt-5.1-codex-max" = {
              name = "GPT-5.1 Codex Max";
            };
            "gpt-5.1-codex-mini" = {
              name = "GPT-5.1 Codex Mini";
            };
            "gpt-5-mini" = {
              name = "GPT-5 Mini";
            };
            # Gemini Family (via Google)
            "gemini-3.1-pro-preview" = {
              name = "Gemini 3.1 Pro Preview";
            };
            "gemini-3-flash-preview" = {
              name = "Gemini 3 Flash Preview";
            };
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
