{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../modules/alacritty.nix
    ../modules/zsh.nix
    ../modules/tmux.nix
    ../modules/git.nix
    ../modules/i3.nix
    ../modules/nushell.nix
    ../modules/obs.nix
    ../modules/mime.nix
    ../modules/vr.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "cjosephs";
    homeDirectory = "/home/cjosephs";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    polkit_gnome
    alvr
    sidequest
    libva
    libva-utils
    vulkan-loader
    vulkan-tools
    cudaPackages.cudatoolkit     
    
    goxel
    unityhub
    # rustup
    dotnetCorePackages.sdk_9_0-bin
    
    # Browsing and Communication
    vivaldi
    slack
    discord
    #evolution
    vlc
    ffmpeg
    system-config-printer
    
    # Development
    arduino
    git
    git-lfs
    git-credential-manager
    gh
    vscode
    go
    gopls
    # gcc
    gcc
    gnumake
    # nodejs
    # coursier
    # dotnet-sdk_7
    direnv
    jetbrains-toolbox
    zoom-us
    zed-editor
    postman
    steam-run
    godot_4
    erlang_28
    gleam
    docker
    scala-next
    mill
    ripgrep
    antigravity-fhs

    jdk17
    libGL
    xorg.libX11
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXi
    xorg.libXcursor
    vulkan-loader
    xorg.libxcb
    xorg.libXrender
    xorg.libXfixes
    xorg.libXext
    libxkbcommon

    # Shell
    kitty
    alacritty
    zsh
    zsh-powerlevel10k
    tmux
    zellij
    nushell
    xsel

    # Notes
    logseq #- depends on outdateed electron

    # Common Utils
    htop
    xclip
    zip
    unzip
    xarchiver
    zenity
    usbutils
    dunst
    networkmanagerapplet
    xdotool
    wmctrl
    # gnome.file-roller
    bat
    jq
    tree
    eza
    (python313.withPackages (ps: with ps; [ jsonpickle pymupdf pip pillow ]))    timer
    speechd
    geeqie
    feh
    tealdeer
    i3lock
    appimage-run
    filezilla
    audacity
    nodejs_22 
    yarn-berry

    # Dependencies
    xorg.libX11
    xorg.xhost
    mesa
    zlib
    glib
    glibc
    icu
    protonup-qt
    picom
    nitrogen

    # Silly
    lolcat
    fortune

    # Misc
    gnupg
    opam
    prusa-slicer
    #cura
    flameshot
    gthumb
    remmina
    tigervnc
    vial
    upscayl
    mob
    easyeffects

    # Fonts
    fira-code
    fira-code-symbols
    monaspace

    # Gaming
    wineWowPackages.full
    winetricks
    protontricks
    lutris
    heroic
    prismlauncher
    cockatrice  # MTG
    xmage       # MTG
    # sunshine

    # Minecraft
    glfw
    openal
    libpulseaudio
    flite
    stdenv.cc.cc.lib

    poppler-utils
    tesseract
  ];

  
  home.sessionPath = [ "$HOME/.yarn/bin" ];
  services.picom.enable = true;

  # services.blueman-applet = {
  #   enable = true;
  # };

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
