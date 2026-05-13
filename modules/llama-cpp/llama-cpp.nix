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
        # RotorQuant/IsoQuant KV cache: iso3(keys) + iso3(values)
        # 3-bit rotation-based KV cache compression from the RotorQuant-enabled fork.
        LLAMA_ARG_CACHE_TYPE_K = "q8_0";
        LLAMA_ARG_CACHE_TYPE_V = "q8_0";

        # Context window
        # LLAMA_ARG_CTX_SIZE = "8192";

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
