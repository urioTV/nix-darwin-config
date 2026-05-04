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
      lib,
      inputs',
      ...
    }:
    {
      imports = [ (sharedConfig { inherit inputs'; }) ];

      environment.systemPackages = with pkgs; [
        llama-cpp
      ];

      environment.variables = {
        # TurboQuant KV cache: turbo3(keys) + turbo4(values)
        # 4.9×/3.8× kompresja vs q8_0 – przy 8K oknie ~58MB zamiast ~289MB
        LLAMA_ARG_CACHE_TYPE_K = "turbo3";
        LLAMA_ARG_CACHE_TYPE_V = "turbo4";

        # Context window
        LLAMA_ARG_CTX_SIZE = "8192";

        # Batch sizes
        LLAMA_ARG_BATCH = "512";
        LLAMA_ARG_UBATCH = "256";

        # Flash attention (faster inference on Metal)
        LLAMA_ARG_FLASH_ATTN = "on";

        # Disable mmap
        LLAMA_ARG_NO_MMAP = "1";
      };
    };
}
