{ inputs, ... }:
let
  sharedSopsConfig =
    { ... }:
    {
      sops = {
        age.sshKeyPaths = [ "/Users/urio/.ssh/id_ed25519" ];
        defaultSopsFile = ./sops/secrets/secrets.yaml;
        secrets = {
          openrouter_api_key = { };
          github_token = { };
          nano-gpt_api_key = { };
          context7_api_key = { };
          z-ai_api_key = { };
        };
      };
    };
in
{
  flake.darwinModules.sops-config = {
    imports = [
      inputs.sops-nix.darwinModules.sops
      sharedSopsConfig
    ];
  };
  flake.homeModules.sops-config = {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
      sharedSopsConfig
    ];
  };
}
