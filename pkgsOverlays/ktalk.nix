{ pkgs }:
let
  version = "3.0.0";
  pname = "ktalk";
  system = "x86_64-linux";

  src = pkgs.fetchurl {
    url =
      "https://st.ktalk.host/ktalk-app/linux/ktalk${version}x86_64.AppImage";
    hash = "sha256-SngWAEYF5rK5iOc/38A0C0LwZCrpLn38knyCPROxZ2k=";
  };

  ktalk = pkgs.appimageTools.wrapType2 {
    inherit pname version system src;
    extraInstallCommands = let
      desktopEntry = ''
        [Desktop Entry]
                Exec=ktalk
                GenericName=Conferencing
                MimeType=x-scheme-handler/ktalk
                Name=Talk
                Terminal=false
                Type=Application
                Version=${version}'';
    in ''
      mkdir -p $out/share/applications
                echo "${desktopEntry}" >$out/share/applications/ktalk.desktop'';
  };
in ktalk

