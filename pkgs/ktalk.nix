{ pkgs }:
let
  version = "3.0.0";
  appimageFile = pkgs.fetchurl {
    url =
      "https://st.ktalk.host/ktalk-app/linux/ktalk${version}x86_64.AppImage";
    hash = "sha256-SngWAEYF5rK5iOc/38A0C0LwZCrpLn38knyCPROxZ2k=";
  };

  ktalk = pkgs.appimageTools.wrapType2 {
    pname = "ktalk";
    version = version;
    system = "x86_64-linux";
    src = appimageFile;

    buildInputs = with pkgs; [ appimage-run ];
    phases = [ "installPhase" ];
    outputs = [ "out" ];

    installPhase = let
      runScript = ''
        #!${pkgs.bash}/bin/bash
                  appimage-run -w ${appimageFile}'';
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
      mkdir -p $out/bin
      mkdir -p $out/share/applications
      echo "${runScript}" >$out/bin/ktalk
      chmod 555 $out/bin/ktalk
      echo "${desktopEntry}" >$out/share/applications/ktalk.desktop
    '';
  };
in ktalk

