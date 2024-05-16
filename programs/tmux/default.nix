{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  # home.file.".config/tmux/theme".source = ./theme;
}
