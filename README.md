# nix-darwin-config

Nix configuration for Darwin (macOS) using flakes, flake-parts, and home-manager.

## Structure

```
.
├── flake.nix              # Entry point: inputs + import-tree ./modules
├── modules/
│   ├── lib/
│   │   └── init.nix       # flake-parts initialization (darwinModules, homeModules, systems)
│   ├── features/          # Shared configurations
│   │   ├── nix/           # Nix settings + opencode overlay
│   │   ├── sops/          # Secrets management
│   │   └── stylix/        # Visual theming (Catppuccin Mocha)
│   ├── hosts/
│   │   └── macbook-air-urio/
│   │       ├── darwin-configurations.nix  # flake.darwinConfigurations
│   │       ├── configuration.nix          # Host-specific settings
│   │       ├── fonts.nix                  # Fonts
│   │       ├── homebrew.nix               # Homebrew packages
│   │       ├── java-jdk.nix               # Java tooling
│   │       └── packages/                  # System packages
│   │       ├── dev.nix
│   │       ├── devops.nix
│   │       ├── nix-tools.nix
│   │       ├── secrets.nix
│   │       └── system.nix
│   └── home/              # Home-manager modules
│       ├── base.nix       # Base home config
│       ├── shells.nix     # Zsh + Prezto + Starship
│       ├── misc.nix       # Misc packages
│       ├── gui-apps.nix   # GUI applications
│       └── programs/
│           └── ai/       # AI tools (opencode, gemini-cli, MCP servers)
├── sops/
│   └── secrets/secrets.yaml  # Encrypted secrets
├── media/
│   └── kosciejo.png       # Wallpaper for Stylix
└── dotfiles/              # Application configs (zed/, antigravity/)
```

## Key Concepts

### Dendritic Pattern

This repository uses the **dendritic pattern** with `flake-parts` and `import-tree`:

- **`flake.nix`**: Minimal entry point that delegates to `import-tree ./modules`
- **`modules/lib/init.nix`**: Defines `flake.darwinModules` and `flake.homeModules` options
- **Each module**: Exports `flake.darwinModules.*` or `flake.homeModules.*`
- **Host config**: Imports modules via `self.darwinModules.*`

### Module Types

| Directory | Purpose |
|-----------|---------|
| `features/` | Shared configs (nix, sops, stylix) |
| `hosts/` | Host-specific configs and packages |
| `home/` | Home-manager modules |
| `lib/` | flake-parts initialization |

## Flake Inputs

- **nixpkgs**: NixOS unstable packages
- **nix-darwin**: macOS system configuration
- **home-manager**: User environment management
- **flake-parts**: Modular flake composition
- **import-tree**: Directory-based module imports
- **sops-nix**: Secrets management
- **stylix**: Visual theming
- **llm-agents**: AI tools (opencode)

## Usage

```bash
# Build and switch
sudo darwin-rebuild switch --flake .#MacBook-Air-Urio

# Dry-run (check only)
darwin-rebuild check --flake .#MacBook-Air-Urio

# Rollback
darwin-rebuild switch --rollback
```

## Customization

| What | Where |
|------|-------|
| System packages | `modules/hosts/macbook-air-urio/packages/*.nix` |
| Homebrew | `modules/hosts/macbook-air-urio/homebrew.nix` |
| Shell | `modules/home/shells.nix` |
| AI tools | `modules/home/programs/ai/*.nix` |
| Secrets | `sops/secrets/secrets.yaml` |
| Theme | `modules/features/stylix/stylix.nix` |

## Features

- **Secrets**: SOPS-nix with age encryption
- **Theming**: Stylix with Catppuccin Mocha
- **Shell**: Zsh + Prezto + Starship
- **AI**: OpenCode, Gemini CLI, MCP servers
- **Containers**: Podman, Docker tools
- **Editor**: Zed with Nix LSP (nixd)