{
  config,
  lib,
  pkgs,
  ...
}:

let
  premiumModel = "github-copilot/claude-sonnet-4.6";
  premiumFallbacks = [
    "google/gemini-3.1-pro"
    "openrouter/zhipuai/glm-5"
    "github-copilot/gpt-5-mini"
  ];

  freeModel = "github-copilot/gpt-5-mini";
  freeFallbacks = [
    "google/gemini-3.0-flash"
    "openrouter/meta-llama/llama-3.1-8b-instruct"
    "github-copilot/gpt-4.1"
  ];
in
{
  xdg.configFile."opencode/oh-my-opencode.json".text = builtins.toJSON {
    google_auth = false;

    agents = {
      sisyphus = {
        category = "unspecified-high";
      };
      prometheus = {
        category = "unspecified-high";
      };
      metis = {
        category = "unspecified-high";
      };
      atlas = {
        category = "unspecified-high";
      };
      hephaestus = {
        category = "unspecified-high";
      };
      oracle = {
        category = "unspecified-high";
      };
      momus = {
        category = "unspecified-high";
      };
      "sisyphus-junior" = {
        category = "quick";
      };
      explore = {
        category = "quick";
      };
      librarian = {
        category = "quick";
      };
      "multimodal-looker" = {
        category = "quick";
      };
    };

    categories = {
      unspecified-high = {
        model = premiumModel;
        fallback = premiumFallbacks;
      };
      ultrabrain = {
        model = premiumModel;
        fallback = premiumFallbacks;
      };
      deep = {
        model = premiumModel;
        fallback = premiumFallbacks;
      };
      artistry = {
        model = premiumModel;
        fallback = premiumFallbacks;
      };
      visual-engineering = {
        model = premiumModel;
        fallback = premiumFallbacks;
      };
      quick = {
        model = freeModel;
        fallback = freeFallbacks;
      };
      unspecified-low = {
        model = freeModel;
        fallback = freeFallbacks;
      };
      writing = {
        model = freeModel;
        fallback = freeFallbacks;
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
            apiKey = "{file:${config.sops.secrets.openrouter_api_key.path}}";
          };
        };
        nano-gpt = {
          options = {
            apiKey = "{file:${config.sops.secrets.nano-gpt_api_key.path}}";
          };
        };
      };
      plugin = [
        "@tarquinen/opencode-dcp@latest"
        "@simonwjackson/opencode-direnv"
        "oh-my-opencode@latest"
        "opencode-gemini-auth@latest"
      ];
    };
  };
}
