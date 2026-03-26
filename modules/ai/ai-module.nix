{ inputs, ... }:
{
  flake.homeModules.ai =
    {
      config,
      pkgs,
      inputs',
      lib,
      self,
      ...
    }:
    {
      imports = [
        ./_ai.nix
        self.homeModules.ai-gemini-cli
        self.homeModules.ai-opencode
      ];
    };
}
