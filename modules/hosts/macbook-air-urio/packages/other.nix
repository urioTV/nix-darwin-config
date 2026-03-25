{ self, inputs, ... }:
{
  flake.darwinModules.other-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [

      ];
    };
}
