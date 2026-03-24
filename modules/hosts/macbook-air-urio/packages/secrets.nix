{ self, inputs, ... }:
{
  flake.darwinModules.secrets-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Zarządzanie zaszyfrowanymi sekretami
        sops
        age
        ssh-to-age
      ];
    };
}
