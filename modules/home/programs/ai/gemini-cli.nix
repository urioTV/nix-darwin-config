{ self, inputs, ... }:
{
  flake.homeModules.ai-gemini-cli =
    { pkgs, ... }:
    {
      programs.gemini-cli = {
        enable = true;
      };
    };
}
