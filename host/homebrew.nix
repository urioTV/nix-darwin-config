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
      "warp"
      # "hyperkey"
      "obsidian"
      "syncthing"
      "localsend"
      "element"
      "protonvpn"
      "spotify"
      "tailscale"
      "zen"
    ];
    brews = [
      "python@3.11"
      "pipx"
      "graphviz"
    ];
  };
}
