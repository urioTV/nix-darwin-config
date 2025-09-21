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

    # Graphical applications (GUI)
    casks = [
      # Code editors
      "visual-studio-code"
      "zed@preview"

      # Media and multimedia
      "vlc"
      "handbrake-app"
      "spotify"

      # Web browsers
      "microsoft-edge"
      "zen"

      # Communication
      "signal"

      # Network and security
      "protonvpn"
      "tailscale-app"
      "rustdesk"

      # System tools
      "keka"
      "macfuse"
      "container"
      "podman-desktop"

      # Productivity and organization
      "obsidian"

      # File synchronization and transfer
      "localsend"
      "syncthing-app"

      # Other
      "qbittorrent"
      "lm-studio"
    ];

    # Command-line tools
    brews = [
      # Programming languages and package managers
      "python@3.11"
      "pipx"

      # Graphics tools
      "graphviz"

      # AI/CLI tools
      "gemini-cli"

      # Containerization
      "podman"
      "podman-compose"
    ];
  };
}
