{
  config,
  pkgs,
  ...
}:
{
  # SOPS configuration for nix-darwin
  # Uses SSH key directly - no manual conversion to age needed
  sops = {
    age.sshKeyPaths = [ "/Users/urio/.ssh/id_ed25519" ];

    # Optional: set default sops file if you want to manage secrets in this repo
    # defaultSopsFile = ./secrets/secrets.yaml;
  };
}
