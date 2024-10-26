{ ... }:

{
  programs.kitty = {
    enable = false;
    extraConfig = builtins.readFile ./kitty.conf;
  };

  home.file.".config/kitty/current-theme.conf".source = ./Catppuccin-Mocha.conf;
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
}
