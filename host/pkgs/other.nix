{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # (writeShellScriptBin "skyve" ''
    #   export WINEPREFIX="$HOME/.wine-skyve"
    #   export WINEARCH=win64

    #   # Wywołanie intelowskich wersji pakietów przez Rosetta 2
    #   WINE_BIN="${pkgsx86_64Darwin.wine64}/bin/wine"
    #   WINETRICKS_BIN="${pkgsx86_64Darwin.winetricks}/bin/winetricks"

    #   # Inicjalizacja prefiksu przy pierwszym uruchomieniu
    #   if [ ! -d "$WINEPREFIX/drive_c/windows/Microsoft.NET/Framework64/v4.0.30319" ]; then
    #     echo "Inicjalizacja środowiska x86_64 i instalacja .NET 4.7.2. To potrwa kilka minut..."
    #     $WINETRICKS_BIN -q dotnet472
    #   fi

    #   # Uruchomienie narzędzia
    #   $WINE_BIN "/Users/urio/Library/Application Support/Steam/steamapps/workshop/content/255710/2881031511/App/Skyve.exe"
    # '')
  ];
}
