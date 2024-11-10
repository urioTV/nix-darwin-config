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
    localsend
    ext4fuse
    cabextract
    p7zip
    zenity
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
      "betterzip"
      "keka"
      "macfuse"
      "handbrake"
      "whisky"
      "warp"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerdfonts
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
}
