{ inputs' }:
final: prev: {
  # libfyaml 0.9.6 generuje na Darwinie błędne `Libs:` w pkg-config:
  # `-lpthread none required -lfyaml`. Meson przenosi `none required` do linkera
  # AppStream, przez co clang próbuje linkować nieistniejące pliki `none` i
  # `required`. Usuwamy wadliwy tekst z pliku .pc w dev output.
  libfyaml = prev.libfyaml.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      substituteInPlace "$dev/lib/pkgconfig/libfyaml.pc" \
        --replace-fail " none required" ""
    '';
  });

  # Overlay z llm-agents.nix dla PI coding agent
  llm-agents = {
    pi = inputs'.llm-agents.packages.pi;
    opencode = inputs'.llm-agents.packages.opencode;
  };

  opencode = inputs'.llm-agents.packages.opencode;
}
