{config, lib, pkgs, ...}:
   
let 
  p10kTheme = ./zsh/p10k.zsh;
  pomodoroScript = ./zsh/pomodoro.sh;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      export PATH=$HOME/.local/bin:$PATH
      [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
      source ${pomodoroScript}
    '';
    shellAliases = {
      ls = "exa -la";
      osup = "sudo nixos-rebuild switch";
      homeup = "home-manager switch";
      nvim = "nix run github:pseudoble/neovim-flake#standard --no-write-lock-file";
      wo="pomodoro 'work'";
      br="pomodoro 'break'";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "thefuck"
        "z"
        "sudo"
        "dirhistory"
      ];
    };
  };
}
