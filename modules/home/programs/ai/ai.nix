{ self, inputs, ... }:
{
  flake.homeModules.ai =
    { config, pkgs, ... }:
    {
      imports = [
        self.homeModules.ai-mcp-servers
        self.homeModules.ai-gemini-cli
        self.homeModules.ai-opencode
        self.homeModules.ai-opencode-providers
        self.homeModules.ai-opencode-oh-my-opencode-slim
        self.homeModules.ai-opencode-skills-import
      ];
    };
}
