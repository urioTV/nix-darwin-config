{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Edytor tekstowy
    micro

    # Multimedia
    ffmpeg_7-full

    # Systemy plików
    ext4fuse

    # Archiwa i kompresja
    cabextract
    p7zip

    # GUI dialogi (skrypty powłoki)
    zenity

    # Narzędzia CLI
    rm-improved
    tldr

    # Inne
    rclone
  ];
}
