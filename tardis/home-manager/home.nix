{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./tmux.nix
    ./git.nix
    ./i3.nix
    ./nushell.nix
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

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Browsing and Communication
    vivaldi
    slack
    discord
    evolution
    vlc 

    # Development
    arduino
    git
    git-lfs
    gh
    vscode
    go
    gopls
    # gcc
    # nodejs
    # coursier
    # dotnet-sdk_7
    direnv
    jetbrains.idea-ultimate
    zoom-us
    zed-editor

    # Shell
    kitty
    alacritty
    zsh
    zsh-powerlevel10k
    tmux
    zellij
    nushell

    # Notes
    logseq

    # Common Utils
    htop
    xclip
    zip 
    unzip
    
    # gnome.file-roller
    bat
    thefuck
    eza
    timer
    speechd
    feh
    tealdeer
    i3lock
    appimage-run
    filezilla

    # Dependencies
    xorg.libX11
    xorg.xhost
    mesa
    zlib
    glib
    glibc
    icu
    protonup-qt

    # Silly
    lolcat
    fortune

    # Misc
    gnupg
    prusa-slicer
    #cura
    flameshot
    gthumb
    remmina
    vial
    upscayl
    mob

    # Fonts
    fira-code
    fira-code-symbols
    monaspace

    # Gaming
    wineWowPackages.full
    winetricks
    protontricks
    lutris
    steam
    prismlauncher

  ];

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
