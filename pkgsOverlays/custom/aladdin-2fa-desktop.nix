{ stdenv, fetchurl, writeShellScript, buildFHSEnv, dpkg, coreutils, xorg
, fontconfig, libGL, makeDesktopItem }:
let
  name = "aladdin-2fa-desktop";
  url = "https://www.aladdin-rd.ru/upload/downloads/aladdin-2fa";
  version = "1.2.0.23";

  desktopItem = makeDesktopItem {
    inherit name;
    desktopName = "Aladdin 2FA Desktop";
    genericName = "Two-factor authentication client";
    comment = "Aladdin 2FA Desktop client for authentication";
    exec = "aladdin-2fa-desktop";
    icon = "aladdin-2fa-desktop";
    categories = [ "Utility" "Security" ];
    startupNotify = false;
    terminal = false;
    type = "Application";
  };

  builder = writeShellScript "builder.sh" ''
    source $stdenv/setup
    PATH=$dpkg/bin:$PATH
    ${dpkg}/bin/dpkg -x $src unpacked
    ${coreutils}/bin/cp -r unpacked/* $out/

    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications/

    if [ -d unpacked/usr/share/icons ]; then
      mkdir -p $out/share/icons
      cp -r unpacked/usr/share/icons/* $out/share/icons/
    elif [ -d unpacked/usr/share/pixmaps ]; then
      mkdir -p $out/share/pixmaps
      cp -r unpacked/usr/share/pixmaps/* $out/share/pixmaps/
    fi
  '';

  aladdin-2fa-desktop-dpkg = stdenv.mkDerivation {
    inherit builder;
    name = "aladdin-2fa-desktop-dpkg";
    src = fetchurl {
      url = "${url}/${name}-x64-${version}.deb";
      sha256 = "sha256-+9QUFG8PO/eN1sc9Z9K4tHEfuO1wXs4XYh/nVfcpAL0=";
    };
  };
in buildFHSEnv {
  inherit name;
  targetPkgs = pkgs: [ aladdin-2fa-desktop-dpkg ];
  multiPkgs = pkgs: [
    dpkg
    fontconfig
    xorg.libX11
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    libGL
  ];
  runScript = "aladdin-2fa-desktop";

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications/
  '';
}
