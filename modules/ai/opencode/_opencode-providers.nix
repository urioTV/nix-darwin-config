{ config, pkgs, ... }:
{
  programs.opencode.settings.provider = {
    openrouter = {
      options = {
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
}
