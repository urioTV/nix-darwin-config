{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    llama-cpp
  ];

  environment.variables = {
    # KV cache quantization (q8_0 = good speed/quality balance)
    LLAMA_ARG_CACHE_TYPE_K = "q8_0";
    LLAMA_ARG_CACHE_TYPE_V = "q8_0";

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
}
