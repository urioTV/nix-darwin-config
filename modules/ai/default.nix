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
        ./_gemini-cli.nix
        ./_opencode.nix
        ./_opencode-providers.nix
        ./_oh-my-opencode.nix
        ./skills/_skills-import.nix
      ];
    };
}
