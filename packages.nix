{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      # Text editor
      micro

      # Multimedia
      ffmpeg_7-full

      # Filesystems
      ext4fuse

      # Archives and compression
      cabextract
      p7zip

      # GUI dialogs (shell scripts)
      zenity

      # CLI tools
      rm-improved
      tldr

      # Other
      rclone
      fastfetch

      # Encrypted secrets management
      sops
      age
      ssh-to-age

      # Nix tools
      nixfmt
      nixd

      # Development
      nodejs
      nodePackages.typescript-language-server
      rustc
      cargo
      gh

      # DevOps
      kubectl
      kubernetes-helm
      opentofu
      tofu-ls
      ansible
      ansible-lint
      pulumi-bin
      act
    ]
    ++ [
      # Symlink terraform -> tofu for compatibility
      (pkgs.runCommand "terraform-tofu-symlink" { } ''
        mkdir -p $out/bin
        ln -s ${pkgs.opentofu}/bin/tofu $out/bin/terraform
      '')
    ];
}
