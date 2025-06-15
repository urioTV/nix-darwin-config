{
  inputs,
  config,
  pkgs,
  ...
}:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "visual-studio-code"
      "vlc"
      "qbittorrent"
      "keka"
      "macfuse"
      "handbrake"
      # "whisky"
      # "hyperkey"
      "obsidian"
      "syncthing"
      "localsend"
      "protonvpn"
      "spotify"
      "tailscale"
      "zen"
      "rustdesk"
    ];
    brews = [
      "python@3.11"
      "pipx"
      "graphviz"
    ];
  };
}
