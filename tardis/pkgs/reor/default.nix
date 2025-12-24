{ lib
, buildNpmPackage
, fetchFromGitHub
, electron
, makeWrapper
, copyDesktopItems
, makeDesktopItem
, bash
}:

buildNpmPackage rec {
  pname = "reor";
  version = "0.2.26";

  src = fetchFromGitHub {
    owner = "reorproject";
    repo = "reor";
    rev = "v${version}";
    hash = "sha256-aOZk0mNG96vBNVt+zCTXccfvW7M6zC2C5ODrUMjgFhA=";
  };

  npmDepsHash = "sha256-+JWLEmZE5FKPnnnVqHzBHCwO4jVjiUva5sWftHh1ojQ=";

  makeCacheWritable = true;

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  npmBuildScript = "type-check";

  preBuild = ''
    # Skip the prebuild script that downloads Ollama
    export npm_config_script_shell=${lib.getBin bash}/bin/bash
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/reor
    cp -r dist dist-electron node_modules package.json $out/share/reor/

    # Create wrapper script
    makeWrapper ${electron}/bin/electron $out/bin/reor \
      --add-flags $out/share/reor/dist-electron/main/index.js \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

    # Install icon
    install -Dm644 electron/assets/reor_logo.png $out/share/pixmaps/reor.png

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "reor";
      exec = "reor %U";
      icon = "reor";
      desktopName = "Reor";
      comment = "AI-powered knowledge management";
      categories = [ "Utility" "Office" ];
      startupWMClass = "Reor";
    })
  ];

  meta = with lib; {
    description = "Private & local AI personal knowledge management app";
    longDescription = ''
      An AI note-taking app that runs models locally using Ollama,
      Transformers.js, and LanceDB for semantic search and RAG capabilities.
    '';
    homepage = "https://www.reorproject.org";
    downloadPage = "https://github.com/reorproject/reor/releases";
    license = licenses.agpl3Only;
    maintainers = [ ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "reor";
  };
}
