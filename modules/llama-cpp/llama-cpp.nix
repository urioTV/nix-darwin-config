{ inputs, ... }:
let
  sharedConfig =
    { inputs', ... }:
    {
      nixpkgs.overlays = [
        (import ./_overlay.nix { inherit inputs'; })
      ];
    };
in
{
  flake.darwinModules.llama-cpp =
    {
      pkgs,
      inputs',
      ...
    }:
    let
      llamaCppZshCompletions =
        pkgs.runCommand "llama-cpp-zsh-completions" { nativeBuildInputs = [ pkgs.llama-cpp ]; }
          ''
            mkdir -p "$out/share/bash-completion/completions" "$out/share/zsh/site-functions"
            llama-cli --completion-bash > "$out/share/bash-completion/completions/llama-cpp" 2>/dev/null

            touch "$out/share/zsh/site-functions/_llama-cpp"
            printf '%s\n' \
              '#compdef llama-cli llama-server' \
              "" \
              '# Generated from llama.cpp bash completion during the Nix build.' \
              '# bashcompinit adapts the generated bash completion to zsh, avoiding any' \
              '# hand-maintained option lists or per-flag completion rules here.' \
              'autoload -Uz bashcompinit' \
              'bashcompinit' \
              "source \"$out/share/bash-completion/completions/llama-cpp\"" \
              '_bash_complete -F _llama_completions "$@"' \
              > "$out/share/zsh/site-functions/_llama-cpp"
          '';
    in
    {
      imports = [ (sharedConfig { inherit inputs'; }) ];

      environment.systemPackages = with pkgs; [
        llama-cpp
        llamaCppZshCompletions
      ];

      environment.variables = {
        LLAMA_ARG_CACHE_TYPE_K = "q8_0";
        LLAMA_ARG_CACHE_TYPE_V = "q8_0";

        # Context window
        # LLAMA_ARG_CTX_SIZE = "8192";

        # Batch sizes
        LLAMA_ARG_BATCH = "2048";
        LLAMA_ARG_UBATCH = "2048";

        # Flash attention (faster inference on Metal)
        LLAMA_ARG_FLASH_ATTN = "on";

        # Disable mmap
        LLAMA_ARG_NO_MMAP = "1";
      };
    };
}
