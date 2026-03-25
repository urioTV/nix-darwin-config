{ self, inputs, ... }:
{
  flake.darwinModules.homebrew =
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

          # Media
          # "spotify"
          # "stremio"
          "vlc"
          "handbrake-app"
          "kindle-previewer"
          "calibre"

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
          # Replaced docker-desktop with orbstack for containerization
          # "podman-desktop"
          # "container"
          "utm"
          "orbstack"

          # Gaming & Emulation
          "playcover-community"

          # System Utilities
          "macfuse"
          "sikarugir"
        ];

        # Command-line tools
        brews = [
          # Programming languages and package managers
          "pipx"

          # Graphics tools
          "graphviz"

          # Kubernetes
          "minikube"
        ];
      };
      environment.variables = {
        HOMEBREW_INSTALL_FROM_API = "1";
      };
    };
}
