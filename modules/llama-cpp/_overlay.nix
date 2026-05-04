{ inputs' }:
final: prev:
let
  turboquant-src = final.fetchFromGitHub {
    owner = "TheTom";
    repo = "llama-cpp-turboquant";
    rev = "4f331667d9badcc71ab864f1e298591061d82050";
    hash = "sha256-hz9BKKD5aCTRAluHfJKlyQkaa+AXAM33uGt/pzEVr8A=";
    leaveDotGit = true;
    postFetch = ''
      git -C "$out" rev-parse --short HEAD > $out/COMMIT
      find "$out" -name .git -print0 | xargs -0 rm -rf
    '';
  };
in
{
  # llama-cpp z TurboQuant – fork TheTom/llama-cpp-turboquant (Metal backend)
  llama-cpp = prev.llama-cpp.overrideAttrs (old: {
    version = "0-turboquant";
    src = turboquant-src;

    # LLAMA_BUILD_NUMBER musi być liczbą (C++ int), nie stringiem
    cmakeFlags =
      builtins.filter (
        f: !(final.lib.hasPrefix "-DLLAMA_BUILD_NUMBER" (if builtins.isString f then f else ""))
      ) old.cmakeFlags
      ++ [ "-DLLAMA_BUILD_NUMBER:STRING=0" ];
  });
}
