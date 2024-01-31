{ ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };

  home.file.".config/kitty/current-theme.conf".source = ./current-theme.conf;
}
