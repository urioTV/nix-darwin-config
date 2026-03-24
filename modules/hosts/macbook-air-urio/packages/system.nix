{ self, inputs, ... }:
{
  flake.darwinModules.system-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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
      ];
    };
}
