{ inputs' }:
final: prev:
let
  llama-cpp-src = final.fetchFromGitHub {
    owner = "ggml-org";
    repo = "llama.cpp";
    rev = "39cf5d61915769124b7efbbfa69c46f19a6363ee";
    hash = "sha256-t/zMw23dD68ElCsho0RL5qh6C5D1QpwMuyL9KKTi00Q=";
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

    # LLAMA_BUILD_NUMBER must be a numeric C++ int. The package version contains
    # the short commit (for example 0-39cf5d6), so do not let CMake derive the
    # build number from it.
    cmakeFlags =
      builtins.filter (
        f: !(final.lib.hasPrefix "-DLLAMA_BUILD_NUMBER" (if builtins.isString f then f else ""))
      ) old.cmakeFlags
      ++ [ "-DLLAMA_BUILD_NUMBER:STRING=0" ];

    preConfigure = ''
      prependToVar cmakeFlags "-DLLAMA_BUILD_COMMIT:STRING=$(cat COMMIT)"
      pushd tools/ui
      npm run build
      popd
    '';
  });
}
