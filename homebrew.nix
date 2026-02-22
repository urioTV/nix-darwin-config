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
    taps = [
      "Sikarugir-App/sikarugir"
    ];

    # Graphical applications (GUI)
    casks = [
      # Development
      # "visual-studio-code"
      # "zed@preview"
      "antigravity"

      # Artificial Intelligence
      "lm-studio"

      # Web browsers
      # "microsoft-edge"
      "zen"
      "brave-browser"

      # Communication
      # "signal"
      # "slack"

      # Productivity
      "obsidian"
      # "logseq"

      # Media
      # "spotify"
      # "stremio"
      "vlc"
      "handbrake-app"

      # Network
      "protonvpn"
      "tailscale-app"
      "rustdesk"

      # File Management
      "localsend"
      "syncthing-app"
      "qbittorrent"
      "keka"
      # "jdownloader"
      "google-drive"

      # Virtualization & Containers
      # "podman-desktop"
      # "container"
      "utm"

      # Gaming & Emulation
      "playcover-community"

      # System Utilities
      "macfuse"
      "sikarugir"
      "docker-desktop"
      "gcloud-cli"
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
  environment.variables = {
    HOMEBREW_INSTALL_FROM_API = "1";
  };
}
