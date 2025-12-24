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
    initContent = ''
      export PATH=$HOME/.local/bin:$PATH
      export PATH=$HOME/.yarn/bin:$PATH
      export PATH=$HOME/.npm-global/bin:$PATH

      [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
      source ${pomodoroScript}
    '';
    shellAliases = {
      ls = "exa -la";
      osup = "sudo nixos-rebuild switch --flake ~/.pseudoble/tardis#nixos";
      homeup = "home-manager switch --flake ~/.pseudoble/tardis#cjosephs@nixos";
      nvim = "nix run github:pseudoble/neovim-flake#standard --no-write-lock-file";
      wo="pomodoro 'work'";
      br="pomodoro 'break'";
      cdb = "builtin cd";
      # claude = "yarn dlx @anthropic-ai/claude-code";
      # gemini = "yarn dlx @google/gemini-cli";
      # codex = "yarn dlx @openai/codex";
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
        "sudo"
        "dirhistory"
      ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
