{ lib
, stdenv
, fetchFromGitHub
, cmake
, obs-studio
, qt6
, wrapQtAppsHook
, curl
}:

stdenv.mkDerivation rec {
  pname = "obs-vertical-canvas";
  version = "1.4.10";

  src = fetchFromGitHub {
    owner = "Aitum";
    repo = "obs-vertical-canvas";
    rev = version;
    hash = "sha256-0XfJ8q8n2ANO0oDtLZhZjRunZ5S1EouQ6Ak/pxEQYOQ=";
  };

  nativeBuildInputs = [ cmake wrapQtAppsHook ];
  buildInputs = [ obs-studio qt6.qtbase curl ];

  cmakeFlags = [
    "-DBUILD_OUT_OF_TREE=ON"
  ];
  # Replace deprecated 'stateChanged' with 'checkStateChanged'
  postPatch = ''
    find . -type f -name '*.cpp' -exec sed -i 's/stateChanged/checkStateChanged/g' {} +
  '';
}