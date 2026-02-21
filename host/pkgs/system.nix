{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Edytor tekstowy
    micro

    # Informacje o systemie
    fastfetch

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
  ];
}
