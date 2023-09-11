{config, lib, pkgs, ...}:
   
let 
  p10kTheme = ./zsh/.p10k.zsh;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      [[ ! -f ${p10kTheme} ]] || source ${p10kTheme}
    '';
    shellAliases = {
      ls = "exa -la";
      osup = "sudo nixos-rebuild switch";
      homeup = "home-manager switch";
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
