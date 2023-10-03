{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./alacritty.nix
    #./nvim.nix
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

    # Development
    # neovim
    git
    gh
    vscode
    # gcc
    # nodejs
    # coursier
    # dotnet-sdk_7
    direnv

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
    gnome.file-roller
    bat
    thefuck
    exa
    timer
    speechd
    feh

    # Dependencies
    xorg.libX11
    xorg.xhost
    mesa
    zlib
    glib
    icu
    
    # Silly
    lolcat
    fortune

    # Misc
    gnupg
    prusa-slicer
    cura

    # Fonts
    fira-code
    fira-code-symbols

    steam
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
