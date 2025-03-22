{
  inputs,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    jdk21
  ];

  system.activationScripts.extraActivation.text = ''
    echo "Linking JDK 21..."
    mkdir -p /Library/Java/JavaVirtualMachines
    ln -sfn ${pkgs.jdk21}/zulu-21.jdk /Library/Java/JavaVirtualMachines/
  '';
}
