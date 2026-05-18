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
      "zed@preview"
      "antigravity"

      # Web browsers
      # "microsoft-edge"
      "zen"
      "brave-browser"

      # Communication
      # "signal"
      # "slack"

      # Productivity
      "obsidian"

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
      "google-drive"
      "onyx"
      "pearcleaner"
      "omnidisksweeper"

      # Virtualization & Containers
      # Replaced docker-desktop with orbstack for containerization
      # "podman-desktop"
      # "container"
      "utm"
      "orbstack"

      # Gaming & Emulation
      "playcover-community"
      "prismlauncher"

      # System Utilities
      "macfuse"
      "sikarugir"
      "obs"
    ];

    # Command-line tools
    brews = [
      # Programming languages and package managers
      "pipx"

      # Graphics tools
      "graphviz"

      # Kubernetes
      "minikube"

      # System utilities
    ];
  };
  environment.variables = {
    HOMEBREW_INSTALL_FROM_API = "1";
  };
}
