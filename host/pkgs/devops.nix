{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Kubernetes
    kubectl
    kubernetes-helm

    # Infrastructure as Code (OpenTofu / Terraform-compatible)
    opentofu
    tofu-ls
    # Symlink terraform -> tofu dla kompatybilności
    (pkgs.runCommand "terraform-tofu-symlink" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.opentofu}/bin/tofu $out/bin/terraform
    '')

    # Ansible
    ansible
    ansible-lint

    # Pulumi (IaC multi-cloud)
    pulumi-bin

    # GitHub Actions runner
    act
  ];
}
