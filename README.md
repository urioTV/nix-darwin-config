# nix-darwin-config
 

 This repository contains a Nix configuration for a Darwin (macOS) system, managed using flakes and home-manager.
 

 ## Overview
 

 The configuration is structured as follows:
 

 -   `flake.nix`: Defines the flake, including inputs (dependencies) and outputs (the Darwin system configuration). It uses `nix-darwin` to build the system and `home-manager` to manage user environment.
 -   `configuration.nix`: Imports host-specific configurations and defines system-wide settings, such as the primary user, security settings, and Nix garbage collection options.
 -   `home.nix`: Configures the user environment using home-manager, including session variables and path settings.
 -   `host/`: Contains host-specific configurations:
  -   `default.nix`: Imports other host configurations.
  -   `pkgs.nix`: Defines packages installed on the system.
  -   `homebrew.nix`: Configures Homebrew, including installed casks and brews.
  -   `fonts.nix`: Configures fonts installed on the system.
  -   `java-jdk.nix`: Configures Java JDK.
 -   `home/programs/`: Contains configurations for user-specific programs:
  -   `default.nix`: Imports configurations for different programs.
  -   `shells.nix`: Configures shell settings, including Zsh with Prezto and Carapace.
 

 ## Key Components
 

 -   **Flakes**: Enables reproducible builds and dependency management using Nix.
 -   **nix-darwin**: Provides modules and tools for configuring macOS systems with Nix.
 -   **home-manager**: Manages user-specific configurations, such as installed packages, shell settings, and environment variables.
 -   **Homebrew**: Used for installing and managing packages from the Homebrew package manager.
 -   **Zsh**: Configured as the primary shell, with Prezto for enhanced features and plugins like autosuggestions and completions.
 

 ## Usage
 

 To use this configuration, you will need Nix and flakes enabled on your macOS system. You can then build and apply the configuration using the following commands:
 

 ```bash
 sudo darwin-rebuild switch --flake .#MacBook-Air-Urio
 ```
 

 Replace `MacBook-Air-Urio` with the actual name of your Darwin system, as defined in `flake.nix`.
 

 ## Customization
 

 You can customize this configuration by modifying the files in the repository. For example, you can add or remove packages in `host/pkgs.nix` or `host/homebrew.nix`, configure shell settings in `home/programs/shells.nix`, or add new programs in `home/programs/default.nix`.
