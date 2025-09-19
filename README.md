# nix-darwin-config

This repository contains a Nix configuration for a Darwin (macOS) system, managed using flakes and home-manager.

## Overview

The configuration is structured as follows:

- `flake.nix`: Defines the flake, including inputs (dependencies) and outputs (the Darwin system configuration). It uses `nix-darwin` to build the system and `home-manager` to manage user environment.
- `configuration.nix`: Imports host-specific configurations and defines system-wide settings, such as the primary user, security settings, and Nix garbage collection options.
- `home.nix`: Configures the user environment using home-manager, including session variables and path settings.
- `homebrew.nix`: Manages packages installed through Homebrew, including GUI applications (casks) and command-line tools (brews).
- `host/`: Contains host-specific configurations:
  - `default.nix`: Imports other host configurations.
  - `pkgs.nix`: Defines packages installed on the system.
  - `fonts.nix`: Configures fonts installed on the system.
  - `java-jdk.nix`: Configures Java JDK.
  - `programs/`: Contains system-level program configurations.
- `home/`: Contains user-specific configurations:
  - `default.nix`: Imports home-manager module configurations.
  - `programs/`: Contains configurations for user-specific programs:
    - `default.nix`: Imports configurations for different programs.
    - `shells.nix`: Configures shell settings, including Zsh with Prezto and Carapace.
- `dotfiles/`: Contains application-specific configuration files:
  - `zed/`: Zed editor configuration including settings, themes, and extensions setup.

## Flake Inputs

This configuration uses the following flake inputs:

- **nixpkgs:** NixOS unstable packages for macOS
- **nix-darwin:** Provides modules and tools for configuring macOS systems with Nix
- **home-manager:** User environment management
- **apple-fonts:** Apple font collection for macOS

## Key Components

- **Flakes**: Enables reproducible builds and dependency management using Nix
- **nix-darwin**: Provides modules and tools for configuring macOS systems with Nix
- **home-manager**: Manages user-specific configurations, such as installed packages, shell settings, and environment variables
- **Homebrew**: Used for installing and managing packages from the Homebrew package manager, including GUI applications and command-line tools
- **Zsh**: Configured as the primary shell, with Prezto for enhanced features and plugins like autosuggestions and completions
- **Containerization**: Podman and Docker tools are available for container management
- **Dotfiles Management**: Application-specific configurations are managed through the `dotfiles/` directory, including Zed editor settings with LSP configuration for Nix development

## Usage

To use this configuration, you will need Nix and flakes enabled on your macOS system. You can then build and apply the configuration using the following commands:

```bash
sudo darwin-rebuild switch --flake .#MacBook-Air-Urio
```

Replace `MacBook-Air-Urio` with the actual name of your Darwin system, as defined in `flake.nix`.

## Customization

You can customize this configuration by modifying the files in the repository:

- **System packages**: Add or remove packages in `host/pkgs.nix`
- **Homebrew packages**: Modify GUI applications (casks) and command-line tools (brews) in `homebrew.nix`
- **Shell configuration**: Configure shell settings in `home/programs/shells.nix`
- **User programs**: Add new programs in `home/programs/default.nix`
- **Application settings**: Customize application settings in the `dotfiles/` directory
- **Development environment**: The Zed editor configuration includes advanced LSP settings for Nix development with nixd language server support

## Additional Features

### Development Tools
- **Zed Editor**: Configured with LSP support for Nix development
- **Visual Studio Code**: Available through Homebrew
- **Programming languages**: Python, Java JDK configured

### Containerization
- **Podman**: Container runtime and desktop application
- **Container tools**: Management tools for container workflows

### System Management
- **Font management**: Apple fonts and system fonts configuration
- **Shell enhancement**: Zsh with Prezto framework
- **Package management**: Hybrid approach using both Nix and Homebrew