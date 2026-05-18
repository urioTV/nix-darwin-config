#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)

cd "$REPO_ROOT"

nix run github:Mic92/nix-update -- \
  --flake \
  --version=branch=master \
  --override-filename modules/llama-cpp/_overlay.nix \
  darwinConfigurations.MacBook-Air-Urio.pkgs.llama-cpp

nix build .#darwinConfigurations.MacBook-Air-Urio.pkgs.llama-cpp \
  --no-link \
  --print-build-logs
