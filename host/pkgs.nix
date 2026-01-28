{
  inputs,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    micro
    nixfmt-rfc-style
    fastfetch
    ffmpeg_7-full
    ext4fuse
    cabextract
    p7zip
    zenity
    rm-improved
    tldr
    nixfmt-rfc-style
    kubectl
    kubernetes-helm
    nodejs
    nixd
    opentofu
    opentofu-ls
    # Symlink terraform -> tofu dla kompatybilności
    (pkgs.runCommand "terraform-tofu-symlink" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.opentofu}/bin/tofu $out/bin/terraform
    '')
    ansible
    rustc
    cargo
    ansible-lint
  ];
}
