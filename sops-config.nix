{ inputs, ... }:
let
  sharedSopsConfig =
    { ... }:
    {
      sops = {
        age.sshKeyPaths = [ "/Users/urio/.ssh/id_ed25519" ];
        defaultSopsFile = ./sops/secrets/secrets.yaml;
        secrets = {
          github_token = { };
          context7_api_key = { };
          litellm_api_key = { };
          litellm_base_url = { };
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
