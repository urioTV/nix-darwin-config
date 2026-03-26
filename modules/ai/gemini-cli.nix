{ inputs, ... }:
{
  flake.homeModules.ai-gemini-cli =
    {
      config,
      pkgs,
      inputs',
      lib,
      self,
      ...
    }:
    {
      programs.gemini-cli = {
        enable = true;
      };
    };
}
