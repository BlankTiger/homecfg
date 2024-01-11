{ ... }: 

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    shellAliases = {
      "ll" = "ls -l";
    };
  };
}
