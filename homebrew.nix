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
      "stremio"

      # Web browsers
      "microsoft-edge"
      "zen"

      # Communication
      "signal"
      "slack"

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
      "logseq"

      # File synchronization and transfer
      "localsend"
      "syncthing-app"

      # Other
      "qbittorrent"
      "lm-studio"
      "anythingllm"
      "playcover-community"
      "Sikarugir-App/sikarugir/sikarugir"
    ];

    # Command-line tools
    brews = [
      # Programming languages and package managers
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
