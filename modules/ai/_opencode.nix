{
  config,
  pkgs,
  inputs',
  ...
}:
{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      model = "opencode-go/glm-5";
      plugin = [
        "opencode-gemini-auth@latest"
        "opencode-lmstudio@latest"
        "@tarquinen/opencode-dcp@latest"
        "@simonwjackson/opencode-direnv"
        "oh-my-opencode-slim@latest"
      ];
    };
  };
}
