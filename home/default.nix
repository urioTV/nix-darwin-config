{ inputs, config, pkgs, ... }: {
  imports = [
    # ./pkgs
    ./programs
    # ./services
  ];
}