{ inputs, config, pkgs, lib, ... }: {
  programs = {
    git = {
      enable = true;
      userEmail = "uriootv@protonmail.com";
      userName = "urioTV";
    };
    zsh = {
      enable = true;
      antidote = {
        enable = false;
        plugins =
          [ "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" ];
      };
      prezto = {
        enable = true;
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
          "autosuggestions"
          "git"
        ];
      };
      shellAliases = {
        nix = "noglob nix";
        nixos-rebuild = "noglob nixos-rebuild";
      };

    };
    eza = { enable = true; };
    bat = { enable = true; };
    starship = {
      enable = true;
      enableZshIntegration = true;
      # settings = {
      #   nix_shell = {
      #     disabled = false;
      #     impure_msg = "";
      #     symbol = "";
      #     format = "[$symbol$state]($style) ";
      #   };
      #   shlvl = {
      #     disabled = false;
      #     symbol = "λ ";
      #   };
      #   haskell.symbol = " ";
      # };
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
