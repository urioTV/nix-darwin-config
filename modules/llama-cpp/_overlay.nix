{ inputs' }:
final: prev:
let
  llama-cpp-src = final.fetchFromGitHub {
    owner = "ggml-org";
    repo = "llama.cpp";
    rev = "053e01dff68dc3419ae8337ea566722138e4376c";
    hash = "sha256-4tq3TdA0MeR/mHk0cEDBBlQdyjjAkOzbun0QB0SasE0=";
    leaveDotGit = true;
    postFetch = ''
      git -C "$out" rev-parse --short HEAD > $out/COMMIT
      find "$out" -name .git -print0 | xargs -0 rm -rf
    '';
  };
in
{
  llama-cpp = prev.llama-cpp.overrideAttrs (old: {
    version = "0-${builtins.substring 0 7 (builtins.readFile "${llama-cpp-src}/COMMIT")}";
    src = llama-cpp-src;

    # Upstream moved web UI from tools/server/webui to tools/ui
    npmRoot = "tools/ui";
    npmDepsHash = "sha256-WaEePrEZ7O/7deP2KJhe0AwiSKYA8HOqETmMHUkmBe0=";

    # Keep this build focused on Apple Silicon/macOS: Metal + Accelerate only.
    # CUDA/ROCm/OpenCL/Vulkan/RPC add irrelevant dependencies or code paths for
    # this host, while tests/examples are not installed or needed at runtime.
    # GGML_NATIVE stays disabled to preserve Nix reproducibility.
    cmakeFlags =
      let
        managedFlags = [
          "CMAKE_C_FLAGS"
          "CMAKE_OSX_ARCHITECTURES"
          "GGML_ACCELERATE"
          "GGML_CLBLAST"
          "GGML_CUDA"
          "GGML_HIP"
          "GGML_METAL"
          "GGML_METAL_EMBED_LIBRARY"
          "GGML_NATIVE"
          "GGML_RPC"
          "GGML_VULKAN"
          "LLAMA_BUILD_EXAMPLES"
          "LLAMA_BUILD_NUMBER"
          "LLAMA_BUILD_TESTS"
          "LLAMA_METAL_EMBED_LIBRARY"
        ];
      in
      builtins.filter (
        f:
        let
          flag = if builtins.isString f then f else "";
        in
        !(builtins.any (name: final.lib.hasPrefix "-D${name}" flag) managedFlags)
      ) old.cmakeFlags
      ++ [
        # LLAMA_BUILD_NUMBER must be a numeric C++ int. The package version
        # contains the short commit (for example 0-39cf5d6), so do not let CMake
        # derive the build number from it.
        "-DLLAMA_BUILD_NUMBER:STRING=0"

        "-DCMAKE_C_FLAGS:STRING=-D__ARM_FEATURE_DOTPROD=1"
        "-DCMAKE_OSX_ARCHITECTURES:STRING=arm64"
        "-DGGML_ACCELERATE:BOOL=ON"
        "-DGGML_CLBLAST:BOOL=OFF"
        "-DGGML_CUDA:BOOL=OFF"
        "-DGGML_HIP:BOOL=OFF"
        "-DGGML_METAL:BOOL=ON"
        "-DGGML_METAL_EMBED_LIBRARY:BOOL=ON"
        "-DGGML_NATIVE:BOOL=OFF"
        "-DGGML_RPC:BOOL=OFF"
        "-DGGML_VULKAN:BOOL=OFF"
        "-DLLAMA_BUILD_EXAMPLES:BOOL=OFF"
        "-DLLAMA_BUILD_TESTS:BOOL=OFF"
      ];

    preConfigure = ''
      prependToVar cmakeFlags "-DLLAMA_BUILD_COMMIT:STRING=$(cat COMMIT)"
      pushd tools/ui
      npm run build
      popd
    '';
  });
}
