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
      "handbrake-app"
      "obsidian"
      "syncthing-app"
      "localsend"
      "protonvpn"
      "spotify"
      "tailscale-app"
      "zen"
      "rustdesk"
      "lm-studio"
      "microsoft-edge"
      "zed@preview"
      "signal"
    ];
    brews = [
      "python@3.11"
      "pipx"
      "graphviz"
      "gemini-cli"
    ];
  };
}
