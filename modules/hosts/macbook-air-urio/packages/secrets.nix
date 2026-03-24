{ self, inputs, ... }:
{
  flake.darwinModules.secrets-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Encrypted secrets management
        sops
        age
        ssh-to-age
      ];
    };
}
