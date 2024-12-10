{
  pkgs,
  self,
  lib,
  ...
}:
{

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    micro
    nixfmt-rfc-style
    fastfetch
    podman
    prismlauncher
    ffmpeg_7-full
    ext4fuse
    cabextract
    p7zip
    zenity
    rm-improved
    tldr
    ollama
  ];

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
      # "betterzip"
      "keka"
      "macfuse"
      "handbrake"
      # "whisky"
      "warp"
      # "hyperkey"
      "obsidian"
      "syncthing"
      "google-drive"
      "localsend"
      "element"
      "protonvpn"
    ];
    brews = [
      "python@3.11"
      "pipx"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerd-fonts.hack
    nerd-fonts.open-dyslexic
    jetbrains-mono
    font-awesome
    ubuntu_font_family
    baekmuk-ttf
    nerd-font-patcher
    corefonts
    open-sans
  ];

  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
  };

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 3d";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = false;
  system.defaults.finder.AppleShowAllFiles = false;
}
