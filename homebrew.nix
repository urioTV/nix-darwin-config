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

    # Aplikacje graficzne (GUI)
    casks = [
      # Edytory kodu
      "visual-studio-code"
      "zed@preview"

      # Media i multimedia
      "vlc"
      "handbrake-app"
      "spotify"

      # Przeglądarki internetowe
      "microsoft-edge"

      # Komunikacja
      "signal"

      # Sieć i bezpieczeństwo
      "protonvpn"
      "tailscale-app"
      "rustdesk"

      # Narzędzia systemowe
      "keka"
      "macfuse"

      # Produktywność i organizacja
      "obsidian"

      # Synchronizacja i transfer plików
      "localsend"
      "syncthing-app"

      # Inne
      "qbittorrent"
      "zen"
      "lm-studio"
    ];

    # Narzędzia wiersza poleceń
    brews = [
      # Języki programowania i menedżery pakietów
      "python@3.11"
      "pipx"

      # Narzędzia graficzne
      "graphviz"

      # Narzędzia AI/CLI
      "gemini-cli"
    ];
  };
}
