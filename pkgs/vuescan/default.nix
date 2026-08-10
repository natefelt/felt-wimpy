{
  # lib,
  stdenv,
  fetchurl,
  gnutar,
  autoPatchelfHook,
  glibc,
  gtk3,
  libxkbcommon,
  libsm,
  libgudev,
  makeDesktopItem,
}:

/*
  Vuescan isn't allowed to be packaged officially
  https://github.com/NixOS/nixpkgs/issues/217996
*/

let
  pname = "vuescan";
  version = "9.8.56";
  desktopItem = makeDesktopItem {
    name = "VueScan";
    desktopName = "VueScan";
    genericName = "Scanning Program";
    comment = "Scanning Program";
    icon = "vuescan";
    terminal = false;
    type = "Application";
    startupNotify = true;
    categories = [
      "Graphics"
      "Utility"
    ];
    keywords = [
      "scan"
      "scanner"
    ];

    exec = "vuescan";
  };
in
stdenv.mkDerivation {
  name = "${pname}-${version}";

  src = fetchurl {
    # version 9.8
    url = "https://www.hamrick.com/files/vuex6498.tgz";
    hash = "sha256-nCeUJ3gfn1oIXIGW1ryCrcw+3QBrMo6s1cEaa5Mk1lU=";

    # version 9.7
    # url = "https://www.hamrick.com/oldfiles/vuex6497.tgz";
    # hash = "sha256-Jx0jw+x9xkckDPS0DXCEY2OuwsnWZ1ZHyk8L8qrG3Qk=";
  };

  # Stripping breaks the program
  dontStrip = true;

  nativeBuildInputs = [
    gnutar
    autoPatchelfHook
  ];

  buildInputs = [
    glibc
    gtk3
    libxkbcommon
    libsm
    libgudev
  ];

  unpackPhase = ''
    tar xfz $src
  '';

  installPhase = ''
    install -m755 -D VueScan/vuescan $out/bin/vuescan

    mkdir -p $out/share/icons/hicolor/scalable/apps/
    cp VueScan/vuescan.svg $out/share/icons/hicolor/scalable/apps/vuescan.svg

    mkdir -p $out/lib/udev/rules.d/
    cp VueScan/vuescan.rul $out/lib/udev/rules.d/60-vuescan.rules

    mkdir -p $out/share/applications/
    ln -s ${desktopItem}/share/applications/* $out/share/applications
  '';
}
