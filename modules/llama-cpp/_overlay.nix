{ inputs' }:
final: prev:
# let
#   rotorquant-src = final.fetchFromGitHub {
#     owner = "johndpope";
#     repo = "llama-cpp-turboquant";
#     rev = "08e025c06ab521e4fa9e5c08b80af57614543e53";
#     hash = "sha256-opn54j6+iPCUXQb7Qm2CHXsfr82Xw0MLszS9l2zmPVQ=";
#     leaveDotGit = true;
#     postFetch = ''
#       git -C "$out" rev-parse --short HEAD > $out/COMMIT
#       find "$out" -name .git -print0 | xargs -0 rm -rf
#     '';
#   };
# in
{
  # llama-cpp z RotorQuant/PlanarQuant – fork johndpope/llama-cpp-turboquant (Metal backend)
  # llama-cpp = prev.llama-cpp.overrideAttrs (old: {
  #   version = "0-rotorquant";
  #   src = rotorquant-src;
  #   npmDepsHash = "sha256-DxgUDVr+kwtW55C4b89Pl+j3u2ILmACcQOvOBjKWAKQ=";

  #   # Forkowy ProgressBar używa sekwencji save/restore cursor, które w części terminali
  #   # powodują zalewanie ekranu podczas pobierania modeli. Wymuszamy prosty pasek
  #   # jednowierszowy na \r, jak w starszym UI.
  #   patches = (old.patches or [ ]) ++ [ ./progressbar-single-line.patch ];

  #   # LLAMA_BUILD_NUMBER musi być liczbą (C++ int), nie stringiem
  #   cmakeFlags =
  #     builtins.filter (
  #       f: !(final.lib.hasPrefix "-DLLAMA_BUILD_NUMBER" (if builtins.isString f then f else ""))
  #     ) old.cmakeFlags
  #     ++ [ "-DLLAMA_BUILD_NUMBER:STRING=0" ];
  # });
}
