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
    vlc-bin
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
    ];
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.

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

  nix.settings.auto-optimise-store = true;

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
}
