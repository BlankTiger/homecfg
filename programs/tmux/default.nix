{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  home.file.".tmux/theme".source = ./theme;
}
