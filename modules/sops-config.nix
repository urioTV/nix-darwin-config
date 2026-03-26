{ inputs, ... }:
let
  sharedSopsConfig =
    { self, ... }:
    {
      sops = {
        age.sshKeyPaths = [ "/Users/urio/.ssh/id_ed25519" ];
        defaultSopsFile = "${self}/sops/secrets/secrets.yaml";

        secrets.openrouter_api_key = { };
        secrets.context7_api_key = { };
        secrets.github_token = { };
        secrets.nano-gpt_api_key = { };
        secrets.z-ai_api_key = { };
        secrets.litellm_api_key = { };
        secrets.notion_api_key = { };
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
